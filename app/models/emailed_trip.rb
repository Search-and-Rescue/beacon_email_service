class EmailedTrip < ActiveRecord::Base
  validates_presence_of :trip_id
end
