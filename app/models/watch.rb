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

   	def complications_attributes=(complication_hashes)
       
         @@complication_result = nil # Used for capturing any complication validation errors when updating a watch

         complication_hashes.each do |i, complication_attributes| 

      		if complication_attributes[:name].present? || complication_attributes[:description].present?

   	   		@complication = Complication.new(name: complication_attributes[:name], description: complication_attributes[:description])
               
               if @complication.save

         			@watch_build = self.complications_watches.build(complication_id: @complication.id)
         			@watch_build.complication_description = @complication.description
         			@watch_build.save

               else

                  if @@watch_create == "yes"
                     @@watch_create = "no"

                     # Capture complication validation errors when creating a watch
                     self.complications << @complication

                  else

                     # Capture complication validation errors when updating a watch
                     # Need this because 'self.complications << @complication' causes app to abort

                     @@complication_result = ""
                     
                     if @complication.errors.messages[:name].size > 0
                        @@complication_result += "Name #{@complication.errors.messages[:name][0]}"
                     end

                     if @complication.errors.messages[:description].size > 0
                        @@complication_result += ", Description #{@complication.errors.messages[:description][0]}"
                     end
       
                  end
                  
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
         
         @@watch_create = "yes"
   		self.create(watch_params)

   	end

      def self.update_watch(watch, params)

         @@watch_create = "no"
         watch.update(params)

         # Complication validation errors captured 
         # for a watch update (if any), else == nil
         @@complication_result

      end

      def self.delete_watch(watch)

         watch.delete

      end   

      def self.delete_join(watch, comp_id)

         watch.complications.delete(comp_id)
         
      end
   		
end

