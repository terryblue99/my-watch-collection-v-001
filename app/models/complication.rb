class Complication < ApplicationRecord
  has_many :complications_watches
  # dependent: :destroy will delete join record when complication is deleted
  has_many :watches, through: :complications_watches, dependent: :destroy

  validates :complication_name, presence: true
  validates :complication_name, uniqueness: true
  validates :complication_description, presence: true

end
