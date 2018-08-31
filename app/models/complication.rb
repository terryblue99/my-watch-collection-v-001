class Complication < ApplicationRecord
  has_many :complications_watches
  has_many :watches, through: :complications_watches

  validates :complication_name, uniqueness: true
  validates :complication_name, presence: true, if: :complication_description_present?
  validates :complication_description, presence: true, if: :complication_name_present?

  def complication_name_present?
    complication_name != ""
  end

  def complication_description_present?
    complication_description != ""
  end

end
