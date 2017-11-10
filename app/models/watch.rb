class Watch < ApplicationRecord
	require 'will_paginate'
	require 'will_paginate/array'	

	belongs_to :user
	has_many :complications_watches
    has_many :complications, through: :complications_watches
   	validates :name, presence: true
   	validates :maker, presence: true

   	def complication_attributes=(attributes)

   		if !attributes[:name].empty? && !attributes[:description].empty?
	   		@cn = Complication.new(name: attributes[:name], description: attributes[:description])
	   		@cn.save
			@watch_build = self.complications_watches.build(complication_id: @cn.id)
			@watch_build.complication_description = Complication.find_by(id: @cn.id).description
			@watch_build.save
			
		end	
   	end

  #  	def self.retrieve_most_maker(maker_rows, current_user)

  #  		if current_user.watches.size > 2 

		# 	most_maker = current_user.watches.group(:maker).order('count_all DESC').limit(1).count
		# 	most_maker_array = current_user.watches.select { |w| w.maker == most_maker.keys[0] }
		# 	most_maker_array = most_maker_array.sort_by(&:name)

		#   	if maker_rows # Selection made of how many watches to display on each page
		#     	@watches = most_maker_array.paginate(:page => params[:page], :per_page => session[:maker_rows])
		#     	# @maker_rows = nil
		#   	else # First time displaying watches
		#     	@watches = most_maker_array.paginate(:page => params[:page], :per_page => 15)
		#   	end

		# else

		# 	@watches = current_user.watches.sort_by(&:name)
		# 	@watches_for_display = @watches.size
		# 	@watches = @watches.paginate(:page => params[:page], :per_page => 15)

		# end 
   		
  #  	end
   		
end
