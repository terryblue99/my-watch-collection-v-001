class ComplicationsWatch < ApplicationRecord
	belongs_to :watch
	belongs_to :complication

	# When trying to save a record in the join table -
	# it fails with "TypeError - nil is not a symbol nor a string"
	# because there is no "primary key".
	# The problem is solved by adding the following line
	self.primary_key = 'watch_id'

	def self.build_join(watch, c_id)
	# Builds the join table entry, acquiring the complication description from the complications table
	    @join_build = watch.complications_watches.build(complication_id: c_id)
		@join_build.complication_description = Complication.find_by(id: c_id).complication_description
		@join_build.save
		@join_build
	end

  def self.description(watch_id, c_id)
  	self.find_by(watch_id: watch_id, complication_id: c_id).complication_description
  end

end
