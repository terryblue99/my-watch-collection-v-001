class ComplicationsWatch < ApplicationRecord
	belongs_to :watch
	belongs_to :complication

	attribute :complication_quantity, :integer, default: 0

end