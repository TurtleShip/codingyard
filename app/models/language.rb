class Language < ActiveRecord::Base

  has_many :codeforces_round_solutions

  validates :name, presence: true
  validates :extension, presence: true

end
