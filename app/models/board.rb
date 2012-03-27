class Board < ActiveRecord::Base

  belongs_to :superboard, :class_name => "Board"
  has_many :subboards, :foreign_key => :superboard_id, :class_name => "Board"
  has_many :topics, :foreign_key => :category_id
  has_many :posts, :through =>:topics
  default_scope order(:displayorder)
  
  def to_s
    "<a href=\"/boards/#{id}\">#{name}</a>".html_safe
  end
  def logo_url
  	  read_attribute(:logo)
  end
  def logo
  	  "<a href=\"/boards/#{id}\"><img src=\"#{logo_url}\"/></a>".html_safe
  end
  def self.root
    Board.find_by_superboard_id 0
  end
end
