class Enroll < ActiveRecord::Base
  attr_accessible :contact, :contact_type, :deck, :name, :team, :score, :tournament_id
  belongs_to :tournament
  belongs_to :user
  has_one :deck, :as => :origin

  validates :name, :presence => true
  validates :contact, :presence => true
  validates :contact_type, :presence => true
end