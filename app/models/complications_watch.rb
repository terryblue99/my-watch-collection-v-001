class ComplicationsWatch < ApplicationRecord
	belongs_to :watch
	belongs_to :complication

end