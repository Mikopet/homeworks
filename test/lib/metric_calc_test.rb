require 'test_helper'
require 'metric_calc'

class MetricCalcTest < ActiveSupport::TestCase
  test "event_counts gives good data" do
    data = MetricCalc::event_counts
    assert data['setup_start'] == 1
    assert data['setup_end'] == 1
    assert data['step_start'] == 5
    assert data['step_end'] == 5
    assert data['pwd_gen'] == 1
  end

  test "event_counts_by_month gives good data" do
    data = MetricCalc::event_counts_by_month.to_a

    assert_nil data.detect { |d| t = d[:name][/step/] ? 5 : 1; d[:data].values.exclude? t }
  end

  test "setup_start_counts_by_month gives good data" do
    data = MetricCalc::setup_start_counts_by_month

    assert data.values.sum == Metric.setup_start.count
  end

  test "setup_counts_cumulated_by_month gives good data" do
    data = MetricCalc::setup_counts_cumulated_by_month.to_a.map { |h| h[:data].values }

    assert data.flatten.sum == Metric.setup.count
  end

  test "completed_setup_by_month gives good data" do
    data = MetricCalc::completed_setup_by_month

  end

  test "average_setup_duration_by_month gives good data" do
    data = MetricCalc::average_setup_duration_by_month

  end
end
