class Language < ActiveRecord::Base

  has_many :codeforces_round_solutions
  has_many :top_coder_srm_solutions
  has_many :uva_solutions

  validates :name, presence: true
  validates :extension, presence: true
  validates :ace_mode, presence: true

  # Returns all extensions of Languages.
  # ex> If extensions are 'java', 'c', 'cpp', this method will return
  # '.java,.c,.cpp'
  def Language.get_all_extensions_concat
    Language.all.map(&:extension).map{ |x| x = '.' + x }.join(',')
  end

end
