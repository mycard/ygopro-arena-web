class Library < ActiveRecord::Base
  belongs_to :parent, :class_name => "Library"
  has_many :decks
  #has_many :cards, :through => :decks
  def cards
    #Card.joins(:duel_user_cards).
  end
end
