class Event < ApplicationRecord
  belongs_to :sport

  validates :name, :due_date, presence: true
  validates :name, uniqueness: true
end
