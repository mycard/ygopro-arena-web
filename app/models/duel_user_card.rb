class DuelUserCard < ActiveRecord::Base
  self.table_name = :duels_users_cards
  belongs_to :duel
  belongs_to :user
  belongs_to :card
end
