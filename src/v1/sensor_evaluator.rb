require 'parser'
require 'statistics'

class SensorEvaluator
  include Parser

  def initialize(log)
    @log = log.each_line
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
        @reference = record
      elsif record.keys == %i[type name]
        current_sensor = record[:name]
        values_by_sensor[current_sensor] ||= { type: record[:type], values: [] }
      elsif record.keys == %i[time value]
        values_by_sensor[current_sensor][:values] << record[:value]
      end
    end

    values_by_sensor
  end
end
