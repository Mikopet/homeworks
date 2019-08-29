class ChartController < ApplicationController
  def show
    @metrics = Metric.all
  end
end
