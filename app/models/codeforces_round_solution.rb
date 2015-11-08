class CodeforcesRoundSolution < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest

  validates :user_id, presence: true
  validates :contest_id, presence: true
end
