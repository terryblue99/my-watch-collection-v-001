class WatchesComplications < ApplicationRecord
	belongs_to :watch
	belongs_to :complication
   		
end