class CodeforcesRoundSolution < ActiveRecord::Base

  include Solution

  validates :round_number, presence: true, numericality: {greater_than: 0}
  validates :division_number, presence: true, inclusion: {in: 1..2}
  validates :level, presence: true, inclusion: %w(A B C D E)
  validates :original_link, length: {maximum: 255}

  before_validation :upcase_level

  def CodeforcesRoundSolution.default_contest
    Contest.codeforces
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
