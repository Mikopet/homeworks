require 'parser'
require 'statistics'

class SensorEvaluator
  include Parser

  def initialize(log)
    raise LoadError if log.empty?

    # not the best idea to load the whole stuff to the memory
    @log = log.lines
  end

  def evaluate
    result = {}

    collect.each do |name, data|
      reference = @reference[data[:type]]

      # Okay, this is a bad practice to easy up this condition hell.
      # Its okay for now, but need to refactor <-- TODO
      verdict = 'discard'

      if data[:type] == :thermometer
        mean_difference = [data[:values].mean, reference].range

        if mean_difference <= 0.5 && data[:values].standard_deviation < 3
          verdict = 'ultra precise'
        elsif mean_difference <= 0.5 && data[:values].standard_deviation < 5
          verdict = 'very precise'
        else
          verdict = 'precise'
        end
      elsif data[:type] == :humidity
        range = (reference-1..reference+1)
        verdict = 'keep' if range.include?(data[:values].max) && range.include?(data[:values].min)
      elsif data[:type] == :monoxide
        range = (reference-3..reference+3)
        verdict = 'keep' if range.include?(data[:values].max) && range.include?(data[:values].min)
      end

      result[name] = verdict
    end

    result
  end

  private

  def collect
    current_sensor = nil
    values_by_sensor = {}

    @log.each do |line|
      record = parse_line(line)

      if record.keys == %i[thermometer humidity monoxide]
        # Yes, we transform the integer value to float too!
        # For the future calculations float is exactly the same, but the code is
        # less complex without handle it otherwise. Even the code is open to future extensions,
        # when we will test the hardware more precisely (or the hardware is able to report more precise)!
        @reference = record.transform_values(&:to_f)
      elsif record.keys == %i[type name]
        current_sensor = record[:name].to_sym
        values_by_sensor[current_sensor] ||= {
          type: record[:type].to_sym,
          values: []
        }
      elsif record.keys == %i[time value]
        values_by_sensor[current_sensor][:values] << record[:value].to_f
      end
    end

    values_by_sensor
  end
end
