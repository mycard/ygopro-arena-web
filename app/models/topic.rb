class Topic < ActiveRecord::Base
  belongs_to :user
  #belongs_to :type
  belongs_to :board, :foreign_key => :category_id
  has_many :posts
  alias category board
  def to_s
    result = name
    if color?
      result = "<font color=\"#{color}\">#{result}</font>"
    end
    result = "<a href=\"/topic/#{id}\">#{result}</a>".html_safe
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
