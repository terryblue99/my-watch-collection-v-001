class Watch < ApplicationRecord

	require "will_paginate"
	require "will_paginate/array"

	belongs_to :user, optional: true
	has_many :complications_watches
  	has_many :complications, through: :complications_watches
  	validates :watch_name, presence: true
 	validates :watch_maker, presence: true
 	# Wire up the model to use Paperclip's has_attached_file method
 	has_attached_file :watch_image, default_url: ":style/default.png", styles: { original: "250x250" }
 	# Provided by Paperclip, and ensures that we get an image file when we expect one
  	validates_attachment_content_type :watch_image, content_type: /\Aimage\/.*\z/


  	validate do |watch|
	    watch.complications.each do |complication|
	       	if !complication.valid?
	          	complication.errors.full_messages.each do |msg|
		          self.errors[:base] << msg
		        end
	       	end
	    end
	end

 	def complications_attributes=(complication_hashes)
	# Custom attribute writer for Nested complication form

       @complication_result = "" # Used for capturing new complication record 
       							 # or any complication validation errors
       @@comp_result_array = []
       
       complication_hashes.each do |i, complication_attributes|
       			
    		if complication_attributes[:complication_name].present? || complication_attributes[:complication_description].present?

	 	   		@complication = Complication.new(complication_name: complication_attributes[:complication_name], complication_description: complication_attributes[:complication_description])

	          	if @complication.save

	          		@@comp_result_array.push("new_complication", @complication)

	       			@join_build = self.complications_watches.build(complication_id: @complication.id)
	       			@join_build.complication_description = @complication.complication_description
	       			@join_build.save

	          	else

	            	if @@watch_create == "yes"

		                @@watch_create = "no"
		                # Capture complication validation errors when creating a watch
		                self.complications << @complication

	              	else
		                # Capture complication validation errors when updating a watch
		                # Need this because 'self.complications << @complication' causes app to abort

		                if @complication.errors.messages[:complication_name].size > 0
		                   @complication_result += "Name #{@complication.errors.messages[:complication_name][0]}"
		                end

		                if @complication.errors.messages[:complication_description].size > 0
		                   @complication_result += ", Description #{@complication.errors.messages[:complication_description][0]}"
		                end

		                @@comp_result_array.push("errors", @complication_result)
	            	end
	            end
	 		end
    	end
 	end

 	def self.search_watches(current_user, watchname)
  	# Search for watches
		search_watches_array = current_user.watches.where("watch_name like ?", "%#{watchname}%")	
		# sorts by maker, name ascending
		search_watches_array = search_watches_array.sort_by{ |w| [w.watch_maker, w.watch_name]}

 	end   

 	def self.find_maker(current_user, maker)
  	# Find a maker and their watches
		find_maker_array = current_user.watches.select { |w| w.watch_maker.downcase == maker.downcase }
		# sorts by watch_name ascending
		find_maker_array = find_maker_array.sort_by(&:watch_name)

 	end

 	def self.retrieve_most_maker(current_user)
  	# Find the maker of most of the watches, and the watches

		# returns the maker with the highest number of occurrences
		most_maker = current_user.watches.group(:watch_maker).order('count_all DESC').limit(1).count
		# returns the maker's watches
		most_maker_array = current_user.watches.select { |w| w.watch_maker == most_maker.keys[0] }
		# sorts by watch_name ascending
		most_maker_array = most_maker_array.sort_by(&:watch_name)

 	end

	def self.retrieve_newest_watches(current_user)
	    # sorts by date bought descending
	    current_user.watches.limit(10).order(date_bought: :desc)
	 end

  	def self.find_watch(watch_id)
     	self.find_by_id(watch_id)
  	end

 	def self.create_watch(watch_params)
    	@@watch_create = "yes"
 		self.create(watch_params)
 	end

	def self.update_watch(this_watch, params)
	  @@watch_create = "no"
	  this_watch.update(params)
	  # new complication record captured if successfully saved
	  # or complication validation errors captured
	  @@comp_result_array
	end

 	def self.sort_complications(this_watch)
	# Initiated by app/views/complications/_load_complications.html.erb

		# Sorts by complication_name ascending
     	watch_complications_sorted = this_watch.complications.sort_by(&:complication_name)
  	end

  	def self.delete_watch(this_watch)
     	# Delete any related complications_watch join records
     	this_watch.complications.delete_all
     	# Find and delete all related complications_watch join records
      	# ComplicationsWatch.where([
		#   "watch_id NOT IN (?) OR complication_id NOT IN (?)",
		#   Watch.pluck("id"),
		#   Complication.pluck("id")
		# ]).destroy_all

		this_watch.destroy
  	end

  	def self.delete_join(this_watch, comp_id)
     	this_watch.complications.delete(comp_id)
  	end

end
