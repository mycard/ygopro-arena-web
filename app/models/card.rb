#encoding: UTF-8
class Card < ActiveRecord::Base
  self.inheritance_column = :inheritance_type #数据库中有type字段与系统冲突，把系统的改名
  
  has_many :duel_user_cards
  has_many :users, :through => :duel_user_card
  has_many :duels, :through => :duel_user_card
  
  scope :monsters, where(:card_type => [:融合怪兽, :同调怪兽, :超量怪兽, :通常怪兽, :效果怪兽, :调整怪兽, :仪式怪兽])
  scope :magics, where(:card_type => [:通常魔法, :速攻魔法, :装备魔法, :场地魔法, :仪式魔法, :永续魔法])
  scope :traps, where(:card_type => [:通常陷阱, :反击陷阱, :永续陷阱])
  scope :extra, where(:card_type => [:融合怪兽, :同调怪兽, :超量怪兽])
  scope :main_monsters, where(:card_type => [:通常怪兽, :效果怪兽, :调整怪兽, :仪式怪兽])
  def image
    "http://card.touhou.cc/images/cards/#{id}.jpg"
  end
  def card_type
    super.to_sym
  end
  def self.top(count)
    #要使用这个方法，必须先joins(:duel_user_cards)，没把这个直接写进来的原因是，如果关系链是从用户调用过来的，那么已经join过了。
    group('cards.id').order("COUNT(cards.id) DESC, cards.id").limit(count)
  end
  def level_name
    if card_type == :超量怪兽
      "阶级"
    else
      "星级"
    end
  end
  def monster?
    [:融合怪兽, :同调怪兽, :超量怪兽, :通常怪兽, :效果怪兽, :调整怪兽, :仪式怪兽].include? card_type 
  end
  def trap?
    [:通常陷阱, :反击陷阱, :永续陷阱].include? card_type 
  end
  def spell?
    [:通常魔法, :速攻魔法, :装备魔法, :场地魔法, :仪式魔法, :永续魔法].include? card_type 
  end
  def extra?
    [:融合怪兽, :同调怪兽, :超量怪兽].include? card_type 
  end
  def to_s
    name
  end
end