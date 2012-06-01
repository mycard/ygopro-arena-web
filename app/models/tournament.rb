class Tournament < ActiveRecord::Base
  attr_accessible :location, :location_type, :name, :note
end
