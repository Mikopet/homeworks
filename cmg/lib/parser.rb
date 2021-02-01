require 'date'

module Parser
  SENSOR_TYPES = %i[thermometer humidity monoxide]
  # I know it seems a bit hacky, but this is a text processing task.
  # RegExp is a powerful tool for that, and for validating is enough for us
  REGEX_REFERENCE = /^reference (?<thermometer>-?\d+\.?\d*) (?<humidity>\d+\.?\d*) (?<monoxide>\d+\.?\d*)$/
  REGEX_SENSOR = /^(?<type>#{SENSOR_TYPES.join('|')}) (?<name>\S+)$/
  REGEX_VALUE = /^(?<time>[0-9\-T:+]+) (?<value>-?\d+\.?\d*)$/

  # Parsing ONE line from log
  def parse_line(line)
    # Check for the VALUE first, that's the most common. Check the REFERENCE last
    # Its not the best at all, but fairly enough now
    match = line.match(REGEX_VALUE) || line.match(REGEX_SENSOR) || line.match(REGEX_REFERENCE)
    raise LoadError if match.nil?

    parsed_line = match.named_captures.transform_keys(&:to_sym)

    # Yes, we transform the integer value to float too!
    # For the future calculations float is exactly the same, but the code is
    # less complex without handle it otherwise. Even the code is open to future extensions,
    # when we will test the hardware more precisely (or the hardware is able to report more precise)!
    if match.regexp == REGEX_REFERENCE
      parsed_line = parsed_line.transform_values(&:to_f)
    elsif match.regexp == REGEX_SENSOR
      parsed_line = parsed_line.transform_values(&:to_sym)
    elsif match.regexp == REGEX_VALUE
      # It's really not necessary, YAGNI yet
      parsed_line[:time] = DateTime.iso8601(parsed_line[:time]).to_time
      parsed_line[:value] = parsed_line[:value].to_f
    end

    parsed_line
  end
end
