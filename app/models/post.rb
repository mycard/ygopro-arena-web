class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :comments
  def self.today
    Post.where(['created_at > ?',  Date.today ])
  end
  def self.yesterday
    Post.where(['created_at < ? and created_at > ?', Date.today, Date.today - 1 ])
  end
  def to_s
  	  "#{topic}, <a href=/topics/#{topic.id}#post#{id}>#{displayorder}#</a>".html_safe
  end
end
