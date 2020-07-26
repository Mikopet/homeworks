class SensorEvaluator
  def initialize(log)
    raise LoadError if log.empty?

    @reference = parse_reference(log.lines.first)

    @log = log
  end

  def evaluate
  end

  private

  def parse_reference(first_line)
    # I know it seems a bit hacky, but this is a text processing task.
    # RegExp is a powerful tool for that, and for validating is enough for us
    match = first_line.match(/^reference (?<thermometer>\d+\.?\d*) (?<humidity>\d+\.?\d*) (?<monoxide>\d+\.?\d*)$/)

    raise LoadError if match.nil?

    # Yes, we transform the integer value to float too!
    # For the future calculations float is exactly the same, but the code is
    # less complex without handle it otherwise. Even the code is open to future extensions,
    # when we will test the hardware more precisely (or the hardware is able to report more precise)!
    match.named_captures.transform_values(&:to_f).transform_keys(&:to_sym)
  end
end
