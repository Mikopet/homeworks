class Sport < ApplicationRecord
  validates :external_id, :name, presence: true
  validates :external_id, uniqueness: true
  validates :name, uniqueness: { scope: :external_id, message: 'This name is already exists with this external_id' }
  validates :name, uniqueness: { scope: :active, message: 'This name is already active in other record' }, if: :active
  validates :active, :inclusion => { :in => [true, false] }

  has_many :events
  has_many :markets

  scope :active, -> { where(active: true) }

  def activate
    self.class.where.not(id: id).where(name: name).map(&:inactivate)
    update(active: true)
  end

  def inactivate
    update(active: false)
  end
end

