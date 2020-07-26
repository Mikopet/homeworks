class SensorEvaluator
  def initialize(log)
    raise LoadError if log.empty?

    @log = log
  end

  def evaluate
  end

  private
end