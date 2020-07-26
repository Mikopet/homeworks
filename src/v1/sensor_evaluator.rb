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
    @log.each do |line|
      # Check for the VALUE first, thats the most common. Check the REFERENCE last
      # Its not the best at all, but fairly enough now
      parsed_line = line.match(REGEX_VALUE) || line.match(REGEX_SENSOR) || line.match(REGEX_REFERENCE)
      raise LoadError if parsed_line.nil?
    end

    # TODO: evaluate them, and return with the solution
    {}
  end

  private

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
