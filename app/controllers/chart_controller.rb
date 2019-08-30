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

  def task
    @options = {
      defer:true
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
    render json: Metric.setups.map { |name, id|
      {
        name: name,
        data: Metric.setup.where(metric_type_id: id).group_by_month(:timestamp).count
      }
    }.chart_json
  end

  ### The Task

  def completed_setup_by_month
    end_ids = Metric.setup_end.select(&:in_a_month?).pluck(:customer_id)
    setups = Metric.setup.where(<<~SQL)
      (
        metric_type_id = 1 AND customer_id NOT IN (#{end_ids.join(',')})
      ) OR (
        metric_type_id = 2 AND customer_id IN (#{end_ids.join(',')})
      )
    SQL

    render json: Metric.setups.map { |name, id|
      {
        name: name == 'setup_start' ? 'SETUP unfinished' : 'SETUP finished',
        data: setups.where(metric_type_id: id).group_by_month(:timestamp, format: '%Y-%m').count
      }
    }.chart_json
  end

  def average_setup_duration_by_month
    current = Metric.setup_end.minimum(:timestamp).beginning_of_month
    max = Metric.setup_end.maximum(:timestamp).beginning_of_month

    months = {}

    while current < max
      arr = Metric.setup_end.where(timestamp: current..current.end_of_month).map{ |m| (m.duration / 3600 / 24).round }
      if arr.any?
        months.merge!(current.strftime('%Y-%m') => arr.inject { |sum, el| sum + el } / arr.size)
      end
      current = current + 1.month
    end

    render json: months
  end
end
