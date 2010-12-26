class Topic < ActiveRecord::Base
  belongs_to :user
  #belongs_to :type
  belongs_to :board, :foreign_key => :category_id
  has_many :posts
  alias category board
  def to_s
    "<a href=\"/topic/#{id}\">#{name}</a>".html_safe
  end
  def floor
  	  self.posts.order('displayorder DESC').first.displayorder + 1
  end
end
