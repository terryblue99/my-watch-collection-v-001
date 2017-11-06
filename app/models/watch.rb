class Watch < ApplicationRecord
	belongs_to :user
	has_many :complications_watches
    has_many :complications, through: :complications_watches
   	validates :name, presence: true
   	validates :maker, presence: true

   	def complication_attributes=(attributes)
   		if !attributes[:name].empty? && !attributes[:description].empty?
	   		@cn = Complication.new(name: attributes[:name], description: attributes[:description])
	   		@cn.save
			self.complications_watches.build(complication_id: @cn.id).save
			@cw = ComplicationsWatch.last
			@cw.complication_description = Complication.find_by(id: @cn.id).description
			@cw.save
		end	
   	end	
   		
end
