class TopCoderSrmSolution < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest

  validates :user_id, presence: true
  validates :contest_id, presence: true
  validates :srm_number, presence: true, numericality: {greater_than: 0}
  validates :division_number, presence: true, inclusion: 1..2
  validates :difficulty, presence: true, inclusion: %w(easy medium hard)

end
