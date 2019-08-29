class ChartController < ApplicationController
  def show
    @metric_types = MetricType.all
    @metrics = Metric.all
  end
end
