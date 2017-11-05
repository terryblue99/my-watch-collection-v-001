class ComplicationsWatch < ApplicationRecord
	belongs_to :watch
	belongs_to :complication

	# When trying to save a record in the join table - 
	# it fails with "TypeError - nil is not a symbol nor a string"
	# because there is no "primary key". 
	# The problem was solved by adding the following line
	self.primary_key = 'watch_id'

end