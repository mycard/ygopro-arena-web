#encoding: UTF-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :nickname, :role_id, :regip, :lastloginip, :viewnum, :onlinetime, :credit1, :credit2, :credit3, :credit4, :credit5, :credit6, :credit7, :credit8
  
  has_attached_file :avatar, :styles => { :middle => ["120x120#", :png], :small => ["48x48#", :png] }, :default_url => lambda { |avatar| "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(avatar.instance.email.strip.downcase)}?size=#{120}" }
  
  has_many :duel_user_cards
  has_many :cards, :through => :duel_user_cards
  has_many :wins, :class_name => "Duel", :foreign_key => :winner_id
  belongs_to :role
  validates :name,  :presence => true,
    :uniqueness => {:case_sensitive => false}
  validates :email, :presence => true,
    :uniqueness => {:case_sensitive => false},
    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  has_many :topics
  has_many :posts, :through => :topics
  def admin?
    true
  end
  def top_duels(count = 20)
    duels.reverse_order.limit(count)
  end
  def duels
    Duel.where("user1_id=? or user2_id=?", id,id)
  end
  def losts
    duels - wins
  end
  
  def to_s
    "<a href=\"/users/#{id}\">#{name}</a>".html_safe
  end
  #  def avatar(size=nil)
  #    size = case size
  #    when :small
  #      48
  #    when Integer
  #      size
  #    else
  #    	120
  #    end
  #    "<a href=\"/users/#{id}\"><img src=\"http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.strip.downcase)}?size=#{size}\" /></a>".html_safe
  #  end
  
  
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
  Guest = User.new :name => 'guest',
    :nickname => '',
    :password => '',
    :email => '',
    :role_id  => 6,
    :regip => '127.0.0.1',
    :lastloginip => '127.0.0.1',
    :viewnum => 0,
    :onlinetime => 0,
    :credit1 => 0,
    :credit2 => 0,
    :credit3 => 0,
    :credit4 => 0,
    :credit5 => 0,
    :credit6 => 0,
    :credit7 => 0,
    :credit8 => 0
  Guest.id = 0
  def Guest.create
  end
end