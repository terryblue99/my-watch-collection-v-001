class Watch < ApplicationRecord
	belongs_to :user
	has_many :watches_complications
    has_many :complications, through: :watches_complications

   	validates :name, presence: true
   	validates :maker, presence: true
   		
end
