class SensorEvaluator
  def initialize(log)
    raise LoadError if log.empty?
    # I know it seems a bit hacky, but this is a text processing task.
    # RegExp is a powerful tool for that, and for validating is enought for us yet
    raise LoadError unless log.lines.first[/reference (\d+\.?\d*) \g<1> \g<1>/]

    @log = log
  end

  def evaluate
  end

  private
end