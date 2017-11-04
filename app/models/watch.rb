class Watch < ApplicationRecord
	belongs_to :user
	has_many :complications_watches
    has_many :complications, through: :complications_watches

   	validates :name, presence: true
   	validates :maker, presence: true

   	def add_comp(complication_id)
      new_comp = ComplicationsWatch.new
      new_comp.watch_id = self.id
      new_comp.complication_id = complication_id
      new_comp.quantity += 1
    end
   		
end
