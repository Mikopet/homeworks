module Parser
  # I know it seems a bit hacky, but this is a text processing task.
  # RegExp is a powerful tool for that, and for validating is enough for us
  REGEX_REFERENCE = /^reference (?<thermometer>\d+\.?\d*) (?<humidity>\d+\.?\d*) (?<monoxide>\d+\.?\d*)$/
  REGEX_SENSOR = /^(?<type>\w+) (?<name>\S+)$/
  REGEX_VALUE = /^(?<time>[0-9\-T:]+) (?<value>\d+\.?\d*)$/

  # Parsing ONE line from log
  def parse_line(line)
    # Check for the VALUE first, that's the most common. Check the REFERENCE last
    # Its not the best at all, but fairly enough now
    parsed_line = line.match(REGEX_VALUE) || line.match(REGEX_SENSOR) || line.match(REGEX_REFERENCE)
    raise LoadError if parsed_line.nil?

    parsed_line.named_captures.transform_keys(&:to_sym)
  end
end
