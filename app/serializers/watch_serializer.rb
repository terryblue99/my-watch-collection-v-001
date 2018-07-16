class WatchSerializer < ActiveModel::Serializer
  attributes :id, :watch_name, :watch_maker, :movement, :band, :model_number, :water_resistance, :date_bought
  has_many :complications
end
