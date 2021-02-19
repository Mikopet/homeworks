class Market < ApplicationRecord
  belongs_to :sport

  validates :name, uniqueness: true, presence: true
end
