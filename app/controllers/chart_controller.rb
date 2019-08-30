require 'metric_calc'

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
      defer: true
    }
  end

  def event_counts
    render json: MetricCalc::event_counts
  end

  def event_counts_by_month
    render json: MetricCalc::event_counts_by_month.chart_json
  end

  def setup_start_counts_by_month
    render json: MetricCalc::setup_start_counts_by_month
  end

  def setup_counts_cumulated_by_month
    render json: MetricCalc::setup_counts_cumulated_by_month.chart_json
  end

  ### The Task

  def completed_setup_by_month
    render json: MetricCalc::completed_setup_by_month.chart_json
  end

  def average_setup_duration_by_month
    render json: MetricCalc::average_setup_duration_by_month
  end
end
