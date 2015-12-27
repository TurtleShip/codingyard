class TopCoderSrmSolution < ActiveRecord::Base

  belongs_to :user
  belongs_to :contest
  belongs_to :language

  validates :user_id, presence: true
  validates :contest_id, presence: true
  validates :language_id, presence: true
  validates :srm_number, presence: true, numericality: {greater_than: 0}
  validates :division_number, presence: true, inclusion: 1..2
  validates :difficulty, presence: true, inclusion: %w(easy medium hard)
  validates :original_link, length: {maximum: 255}

  before_validation :downcase_difficulty

  acts_as_votable

  def TopCoderSrmSolution.new_with_relations(params, user, language)
    solution = new(params)
    solution.user = user
    solution.contest = Contest.topcoder
    solution.language = language
    solution
  end

  def create_save_path(file)
    digest = Digest::MD5.hexdigest(file)
    path = "topcoder/srm/#{srm_number}/div#{division_number}/#{difficulty}/#{user.username}"
    path += "/#{Time.now.to_i}-#{digest}.#{language.extension}"
    path
  end

  private
    def downcase_difficulty
      difficulty.downcase! unless difficulty.nil?
    end

end
