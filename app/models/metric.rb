class Metric < ApplicationRecord
  enum metric_type_id: {
    setup_start: 1,
    setup_end: 2,
    step_start: 3,
    step_end: 4,
    pwd_gen: 5
  }

  scope :setup, -> { where(metric_type_id: [:setup_start, :setup_end]) }

  def setup_pair
    scope = setup_start? ? :setup_end : :setup_start
    Metric.send(scope).find_by(customer_id: customer_id)
  end

  def in_a_month?
    timestamp.beginning_of_month == setup_pair.timestamp.beginning_of_month
  end

  def duration
    timestamp - setup_pair.timestamp
  end

  class << self
    def setups
      metric_type_ids.first(2).to_h
    end
  end
end
