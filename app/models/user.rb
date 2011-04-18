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
  class <<self  #TODO
    alias old_find find
    def find(*args)
      if args[0] == 0
        Guest
      else
        old_find(*args)
      end
    end
  end
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
  Guest = User.new do |user|
    user.id = 0
    user.name = 'guest'
    user.nickname = ''
    user.password = ''
    user.email = ''
    #usergroup = 0
    #admingroup = 0
    user.regip = '127.0.0.1'
    user.lastloginip = '127.0.0.1'
    user.readnum = 0
    user.viewnum = 0
    user.onlinetime = 0
    user.credit = 0
    user.credit1 = 0
    user.credit2 = 0
    user.credit3 = 0
    user.credit4 = 0
    user.credit5 = 0
    user.credit6 = 0
    user.credit7 = 0
    user.credit8 = 0
  end
end
