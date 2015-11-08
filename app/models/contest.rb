class Contest < ActiveRecord::Base

  has_many :top_coder_srm_solutions, dependent: :destroy

  validates :name, uniqueness: true, presence: true, length: {in: 1..50}
  validates :url, uniqueness: false, presence: false, url: {:no_local => true}

  before_save :downcase_name

  private
  def downcase_name
    name.downcase!
  end

end
