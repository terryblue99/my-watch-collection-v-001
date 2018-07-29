class Complication < ApplicationRecord
  has_many :complications_watches
  has_many :watches, through: :complications_watches

  validates :complication_name, presence: true
  validates :complication_name, uniqueness: true
  validates :complication_description, presence: true

end
