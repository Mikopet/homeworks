class MetricCalc
  class << self
    def event_counts
      Metric.all.group(:metric_type_id).count
    end

    def event_counts_by_month
      Metric.metric_type_ids.map { |name, id|
        {
          name: name,
          data: Metric.all.where(metric_type_id: id).group_by_month(:timestamp).count
        }
      }
    end

    def setup_start_counts_by_month
      Metric.setup_start.group_by_month(:timestamp).count
    end

    def setup_counts_cumulated_by_month
      Metric.setups.map { |name, id|
        {
          name: name,
          data: Metric.setup.where(metric_type_id: id).group_by_month(:timestamp).count
        }
      }
    end

    def completed_setup_by_month
      end_ids = Metric.setup_end.select(&:in_a_month?).pluck(:customer_id)
      setups = Metric.setup.where(<<~SQL)
      (
        metric_type_id = 1 AND customer_id NOT IN (#{end_ids.join(',')})
      ) OR (
        metric_type_id = 2 AND customer_id IN (#{end_ids.join(',')})
      )
      SQL

      Metric.setups.map { |name, id|
        {
          name: name == 'setup_start' ? 'SETUP unfinished' : 'SETUP finished',
          data: setups.where(metric_type_id: id).group_by_month(:timestamp, format: '%Y-%m').count
        }
      }
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

      months
    end
  end
end
