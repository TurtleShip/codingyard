class CodeforcesRoundSolution < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest

  validates :user_id, presence: true
  validates :contest_id, presence: true
  validates :round_number, presence: true, numericality: {greater_than: 0}
  validates :division_number, presence: true, inclusion: {in: 1..2}
  validates :level, presence: true, inclusion: %w(A B C D E)

  before_validation :upcase_level

  private
    def upcase_level
      level.upcase! unless level.nil?
    end
end
