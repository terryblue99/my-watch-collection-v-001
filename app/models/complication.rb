class Complication < ApplicationRecord
	has_many :complications_watches
    has_many :watches, through: :complications_watches

    validates :name, presence: true

end
