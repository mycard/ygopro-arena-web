class Match < ActiveRecord::Base
  belongs_to :player1, :class_name => "User"
  belongs_to :player2, :class_name => "User"
  belongs_to :duel1, :class_name => "Duel"
  belongs_to :duel2, :class_name => "Duel"
  belongs_to :duel3, :class_name => "Duel"
  belongs_to :tournament
  #attr_accessible :player1_score, :player2_score, :round
end
