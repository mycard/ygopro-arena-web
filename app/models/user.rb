class User < ActiveRecord::Base
  belongs_to :role

  validates :name,  :presence => true,
                    :length => {:minimum => 1, :maximum => 254}  
  validates :email, :presence => true,   
                    :length => {:minimum => 3, :maximum => 254},  
                    :uniqueness => true,  
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  has_many :topics
  has_many :posts, :through => :topics
  
  class <<self  #TODO
    alias old_find find
    def find(*args)
      if args[0].to_i.zero?
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
  def credit
    credit1
  end
  Guest = User.new do |user|
    user.id = 0
    user.name = 'guest'
    user.nickname = ''
    user.password = ''
    user.email = ''
    user.role_id  = 6
    user.regip = '127.0.0.1'
    user.lastloginip = '127.0.0.1'
    user.viewnum = 0
    user.onlinetime = 0
    user.credit1 = 0
    user.credit2 = 0
    user.credit3 = 0
    user.credit4 = 0
    user.credit5 = 0
    user.credit6 = 0
    user.credit7 = 0
    user.credit8 = 0
    def user.create
    end
   end
end
