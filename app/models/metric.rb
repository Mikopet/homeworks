class Metric < ApplicationRecord
  enum metric_type_id: {
    setup_start: 1,
    setup_end: 2,
    step_start: 3,
    step_end: 4,
    pwd_gen: 5
  }
end
