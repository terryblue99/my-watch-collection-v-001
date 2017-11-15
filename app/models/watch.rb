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
                  self.errors[:base] << msg
               end
            end
         end 
      end

   	def complication_attributes=(attributes)
        
   		if !attributes[:name].empty? || !attributes[:description].empty?

	   		@complication = Complication.new(name: attributes[:name], description: attributes[:description])
            
	   		if @complication.save
      			@watch_build = self.complications_watches.build(complication_id: @complication.id)
      			@watch_build.complication_description = @complication.description
      			@watch_build.save
            else
               # Add the errored out complication to the watch's
               # complication array, making the custom validator fail      
               begin
                  self.complications << @complication
               rescue => invalid_complication
                  throw invalid_complication
               end
               
            end
			   
		   end

   	end

   	def self.retrieve_most_maker(current_user)

   		most_maker = current_user.watches.group(:maker).order('count_all DESC').limit(1).count
   		most_maker_array = current_user.watches.select { |w| w.maker == most_maker.keys[0] }
   		most_maker_array = most_maker_array.sort_by(&:name)

   	end

      def self.find_watch(watch_id)
         
         self.find_by_id(watch_id)

      end   

   	def self.create_watch(watch_params)
         
   		self.create(watch_params)

   	end

      def self.update_watch(watch, params)
      
         watch.update(params)

      end

      def self.delete_watch(watch)

         watch.delete

      end   

      def self.delete_join(watch, comp_id)

         watch.complications.delete(comp_id)
         
      end
   		
end

