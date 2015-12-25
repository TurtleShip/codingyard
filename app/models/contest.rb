class Contest < ActiveRecord::Base

  has_many :top_coder_srm_solutions, dependent: :destroy
  has_many :codeforces_round_solutions, dependent: :destroy

  validates :name, uniqueness: {case_sensitive: false}, presence: true, length: {in: 1..50}
  validates :url, uniqueness: false, presence: false, url: {:no_local => true}

  def Contest.codeforces
    @codeforces ||= find_by_name('Codeforces')
  end

  def Contest.topcoder
    @topcoder ||= find_by_name('TopCoder')
  end

end
