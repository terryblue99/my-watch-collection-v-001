class Watch < ApplicationRecord
	belongs_to :user
	has_many :complications_watches
    has_many :complications, through: :complications_watches

   	validates :name, presence: true
   	validates :maker, presence: true
   		
end
