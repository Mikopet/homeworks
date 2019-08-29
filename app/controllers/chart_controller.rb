class ChartController < ApplicationController
  def index
    @options = {
      legend: :bottom,
      defer: true,
      refresh: 10,
      width: '50%',
      height: '400px'
    }
  end

  def event_counts
    render json: Metric.all.group(:metric_type_id).count
  end

  def event_counts_by_month
    render json: Metric.metric_type_ids.map { |name, id|
      {
        name: name,
        data: Metric.all.where(metric_type_id: id).group_by_month(:timestamp).count
      }
    }.chart_json
  end

  def setup_start_counts_by_month
    render json: Metric.setup_start.group_by_month(:timestamp).count
  end

  def setup_counts_cumulated_by_month
    render json: Metric.metric_type_ids.map { |name, id|
      {
        name: name,
        data: Metric.setup.where(metric_type_id: id).group_by_month(:timestamp).count
      }
    }.chart_json
  end

  private

  def multiple_series

  end
end
