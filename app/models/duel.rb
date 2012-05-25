#encoding: UTF-8
class Duel < ActiveRecord::Base
  belongs_to :user1, :class_name => "User"
  belongs_to :user2, :class_name => "User"
  belongs_to :winner, :class_name => "User"
  has_many :duel_user_cards
  has_many :cards, :through => :duel_user_cards
  def user_cards(user, main)
    main_order = [:通常怪兽, :仪式怪兽, :效果怪兽, :调整怪兽, :通常魔法, :速攻魔法, :装备魔法, :场地魔法, :仪式魔法, :永续魔法, :通常陷阱, :反击陷阱, :永续陷阱]
    extra_order = [:融合怪兽, :同调怪兽, :超量怪兽]
    result = cards.where('user_id=? and main = ?', user, main)
    result.order("field(card_type, #{(main ? main_order : extra_order).collect{|type|"'#{type}'"}.join(',')})", 'cards.id')
  end
  def replay
    "http://122.0.65.71:7933/#{super}"
  end
  def user1
    super || User::Guest
  end
  def user2
    super || User::Guest
  end
  def winner
    super || User::Guest
  end
  def user1_main
    user_cards(user1, true)
  end
  def user1_extra
    user_cards(user1, false)
  end
  def user2_main
    user_cards(user2, true)
  end
  def user2_extra
    user_cards(user2, false)
  end
  def to_s
    Duel.human_attribute_name(:detail)
  end
end
