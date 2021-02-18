class Sport < ApplicationRecord
  validates :external_id, :name, presence: true
  validates :external_id, uniqueness: true
  validates :name, uniqueness: { scope: :external_id, message: 'This name is already exists with this external_id' }
  validates :active, :inclusion => { :in => [true, false] }

  scope :active, -> { where(active: true) }
end
