class Tournament < ActiveRecord::Base
  attr_accessible :location, :location_type, :name, :note, :status, :report, :created_at, :need_deck, :need_team, :need_user
  has_many :matches
  has_many :enrolls
  belongs_to :user
  has_many :users, :through => :enrolls
  has_many :referees
end
