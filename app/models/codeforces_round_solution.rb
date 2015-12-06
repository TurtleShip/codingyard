class CodeforcesRoundSolution < ActiveRecord::Base

  belongs_to :user
  belongs_to :contest
  belongs_to :language

  validates :user_id, presence: true
  validates :contest_id, presence: true
  validates :language_id, presence: true
  validates :round_number, presence: true, numericality: {greater_than: 0}
  validates :division_number, presence: true, inclusion: {in: 1..2}
  validates :level, presence: true, inclusion: %w(A B C D E)

  before_validation :upcase_level

  def CodeforcesRoundSolution.new_with_relations(params, user, language)
    solution = new(params)
    solution.user = user
    solution.contest = Contest.codeforces
    solution.language = language
    solution
  end

  def create_save_path(file)
    digest = Digest::MD5.hexdigest(file)
    path = "codeforces/round/#{round_number}/div#{division_number}/#{user.username}"
    path += "/#{Time.now.to_i}-#{digest}.#{language.extension}"
    path
  end

  private
    def upcase_level
      level.upcase! unless level.nil?
    end
end
