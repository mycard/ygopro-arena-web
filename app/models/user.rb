class User < ActiveRecord::Base
  #belongs_to :usergroup
  #belongs_to :admingroup
  validates_uniqueness_of :name
  def to_s
  	  "<a href=\"/space/#{id}\">#{name}</a>".html_safe
  end
end
