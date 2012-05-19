class Attachment < ActiveRecord::Base
  belongs_to :post
  has_attached_file :data
end
