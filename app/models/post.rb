class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :comments
  def self.today
    #now = Time.now
   # today = Time.mktime(now.year)
    Post.where(['created_at > ?',  Date.today ])
    
  end
  def self.yesterday
    Post.where(['created_at > ? & created_at <? ', Date.today-1, Date.today ])
    #Posts.find(:all, :conditions => ["DATE(created_at) = ?", Date.today-1]
  end
    
    #Today
#Posts.find(:all, :conditions => ["DATE(created_at) = ?", ]
#Yesterday

  #end
end
