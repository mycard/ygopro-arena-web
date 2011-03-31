class User < ActiveRecord::Base
  #belongs_to :usergroup
  #belongs_to :admingroup
  validates :name,  :presence => true,
                    :length => {:minimum => 1, :maximum => 254}  
  validates :email, :presence => true,   
                    :length => {:minimum => 3, :maximum => 254},  
                    :uniqueness => true,  
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  has_many :topics
  has_many :posts, :through => :topics
  before_save proc{!locked}
  def to_s
  	  "<a href=\"/users/#{id}\">#{name}</a>".html_safe
  end
  def avatar(size=nil)
  	  size = case size
  	  when :small
  	  	48
      when Integer
      	size
      else
    	120
      end
  	  "<a href=\"/users/#{id}\"><img src=\"http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.strip.downcase)}?size=#{size}\" /></a>".html_safe
  end
=begin
      t.string :name, :null => false
      t.string :nickname, :default => '', :null => false
      t.string :password, :null => false
      t.string :email, :default => '', :null => false
      t.references :usergroup, :default => '', :null => false
      t.references :admingroup, :default => '', :null => false
      t.string :regip, :default => '', :null => false
      t.string :lastloginip, :default => '', :null => false
      t.integer :readnum, :default => 0, :null => false
      t.integer :viewnum, :default => 0, :null => false
      t.integer :onlinetime, :default => 0, :null => false
      t.integer :credit, :default => 0, :null => false
      t.integer :credit1, :default => 0, :null => false
      t.integer :credit2, :default => 0, :null => false
      t.integer :credit3, :default => 0, :null => false
      t.integer :credit4, :default => 0, :null => false
      t.integer :credit5, :default => 0, :null => false
      t.integer :credit6, :default => 0, :null => false
      t.integer :credit7, :default => 0, :null => false
      t.integer :credit8, :default => 0, :null => false
=end
  Guest = User.find 0
end
