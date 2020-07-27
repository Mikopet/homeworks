require 'statistics'

class SensorEvaluator
  REGEX_REFERENCE = /^reference (?<thermometer>\d+\.?\d*) (?<humidity>\d+\.?\d*) (?<monoxide>\d+\.?\d*)$/
  REGEX_SENSOR = /^(?<sensor>\w+) (?<name>\S+)$/
  REGEX_VALUE = /^(?<date>[0-9\-T:]+) (?<value>\d+\.?\d*)$/

  def initialize(log)
    raise LoadError if log.empty?

    # not the best idea to load the whole stuff to the memory
    @log = log.lines
    @reference = parse_reference(@log.first)
  end

  def evaluate
    result = {}

    collect.each do |name, data|
      reference = @reference[data[:type]]

      if data[:type] == :thermometer
        mean_difference = [data[:values].mean, reference].range

        if mean_difference <= 0.5 && data[:values].standard_deviation < 3
          verdict = 'ultra precise'
        elsif mean_difference <= 0.5 && data[:values].standard_deviation < 5
          verdict = 'very precise'
        else
          verdict = 'precise'
        end

      else
        # Okay, this is a bad practice to easy up this condition hell.
        # Its okay for now, but need to refactor <-- TODO
        verdict = 'discard'
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
      # Check for the VALUE first, that's the most common. Check the REFERENCE last
      # Its not the best at all, but fairly enough now
      parsed_line = line.match(REGEX_VALUE) || line.match(REGEX_SENSOR) || line.match(REGEX_REFERENCE)
      raise LoadError if parsed_line.nil?

      record = parsed_line.named_captures

      if record.keys.include?('sensor')
        current_sensor = record['name'].to_sym
        values_by_sensor[current_sensor] ||= {
          type: record['sensor'].to_sym,
          values: []
        }
      elsif record.keys.include?('date')
        values_by_sensor[current_sensor][:values] << record['value'].to_f
      end
    end

    values_by_sensor
  end

  def parse_reference(first_line)
    # I know it seems a bit hacky, but this is a text processing task.
    # RegExp is a powerful tool for that, and for validating is enough for us
    match = first_line.match(REGEX_REFERENCE)

    raise LoadError if match.nil?

    # Yes, we transform the integer value to float too!
    # For the future calculations float is exactly the same, but the code is
    # less complex without handle it otherwise. Even the code is open to future extensions,
    # when we will test the hardware more precisely (or the hardware is able to report more precise)!
    match.named_captures.transform_values(&:to_f).transform_keys(&:to_sym)
  end
end
