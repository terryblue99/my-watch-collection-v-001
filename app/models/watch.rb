class Watch < ApplicationRecord
	require 'will_paginate'
	require 'will_paginate/array'	

	belongs_to :user
	has_many :complications_watches
   has_many :complications, through: :complications_watches
   validates :name, presence: true
   validates :maker, presence: true

   validate do |watch|
      watch.complications.each do |complication|
         if !complication.valid?
            complication.errors.full_messages.each do |msg|
               self.errors[:base] << "'#{complication.name}': #{msg}"
            end
         end   
      end
   end

   	def complication_attributes=(attributes)

   		if !attributes[:name].empty? && !attributes[:description].empty?

	   		@complication = Complication.new(name: attributes[:name], description: attributes[:description])
            @complication.errors.add(:name, :not_valid, message: "The new complication is invalid")

	   		if @complication.save
      			@watch_build = self.complications_watches.build(complication_id: @complication.id)
      			@watch_build.complication_description = @complication.description
      			@watch_build.save
            else
               # Add the errored out complication to the watch's
               # complication array, making the custom validator fail
               binding.pry
               self.complications << @complication
            end
			
		   end

   	end

   	def self.retrieve_most_maker(current_user)

   		most_maker = current_user.watches.group(:maker).order('count_all DESC').limit(1).count
   		most_maker_array = current_user.watches.select { |w| w.maker == most_maker.keys[0] }
   		most_maker_array = most_maker_array.sort_by(&:name)

   	end

   	def self.create_watch(watch_params)
         
   		self.create(watch_params)

   	end


   	def self.update_watch(watch_params)

   		self.update(watch_params)
   		
   	end
   		
end
