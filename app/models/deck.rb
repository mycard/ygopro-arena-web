class Deck < ActiveRecord::Base
  #has_many :cards, :through => 
  belongs_to :user
  belongs_to :duel
  belongs_to :library
end
