class Notice < ActiveRecord::Base
  belongs_to :user
  #belongs_to :assocaion
  #belongs_to :from_user, :as => :user, :foreign_key => :from_user_id
end
