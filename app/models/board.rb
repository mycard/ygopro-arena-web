class Board < ActiveRecord::Base
  belongs_to :superboard, :foreign_key => :super_id, :class_name => "::Board"
  has_many :subboards, :foreign_key => :super_id, :class_name => "::Board"#, :as => :boards
  											#why it doesn't work?
  has_many :topics, :foreign_key => :category_id
  has_many :posts, :through =>:topics
  def to_s
    "<a href=\"/forum/#{id}\">#{name}</a>".html_safe
  end
  alias topics_with_deleted topics
  def topics
    topics_with_deleted.where({:deleted => false})
  end
  #def superboard
  #	  board
  #end
  #def subboards
  #	  p "-------------------------"
  #	  p boards
  #	  boards
  #	
  #end
end
