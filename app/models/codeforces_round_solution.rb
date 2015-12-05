class CodeforcesRoundSolution < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest

  validates :user_id, presence: true
  validates :contest_id, presence: true
  validates :round_number, presence: true, numericality: {greater_than: 0}
  validates :division_number, presence: true, inclusion: {in: 1..2}
  validates :level, presence: true, inclusion: %w(A B C D E)

  before_validation :upcase_level

  def CodeforcesRoundSolution.new_with_relations!(params, user, contest)
    solution = init_relations params, user, contest
    solution.save!
    solution
  end

  def CodeforcesRoundSolution.new_with_relations(params, user, contest)
    solution = init_relations params, user, contest
    solution.save
  end


  private
  def CodeforcesRoundSolution.init_relations(params, user, contest)
    solution = new(params)
    solution.user = user
    solution.contest = contest
    solution
  end

  def upcase_level
    level.upcase! unless level.nil?
  end
end
