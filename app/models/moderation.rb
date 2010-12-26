class Moderation < ActiveRecord::Base
  belongs_to :user
  belongs_to :association, :polymorphic => true
end
