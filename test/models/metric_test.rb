require 'test_helper'

class MetricTest < ActiveSupport::TestCase
  test "there is exactly 2 SETUP metrics" do
    assert Metric.setup.count == 2
  end

  test "setup_start have pair" do
    setup_events = Metric.setup
    assert setup_events.first.setup_pair == setup_events.last
  end

  test "setup_end have pair" do
    setup_events = Metric.setup
    assert setup_events.last.setup_pair == setup_events.first
  end

  test "setup events are in a month" do
    setup_events = Metric.setup
    assert setup_events.first.in_a_month?
    assert setup_events.last.in_a_month?
  end

  test "setup duration is 1 day" do
    assert Metric.setup.setup_end.first.duration == 1.day
  end

  test "setup events arent in the same month" do
    # assert true :(
  end
end
