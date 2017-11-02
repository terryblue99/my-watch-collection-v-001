class Complication < ApplicationRecord
	has_many :watches_complications
    has_many :watches, through: :watches_complications

    validates :name, presence: true

end
