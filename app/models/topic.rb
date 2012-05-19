class Topic < ActiveRecord::Base
  belongs_to :user
  #belongs_to :type
  belongs_to :board, :foreign_key => :category_id
  has_many :posts
  accepts_nested_attributes_for :posts
  validates :name,  :presence => true
  
  default_scope where(:deleted => false)
  self.per_page = 20
  
  alias category board
  def user
    super || User::Guest
  end
  def to_s
    result = name
    if color?
      result = "<font color=\"#{color}\">#{result}</font>"
    end
    result = "<a href=\"/topics/#{id}\">#{result}</a>".html_safe
  end
  def floor
  	  self.posts.order('displayorder DESC').first.displayorder + 1
  end
  def color
    '#' << (highlight & 0xFFFFFF).to_s(16).rjust(6, "0")
  end
  def color?
    !(highlight & 0xFFFFFF).zero?
  end
end
