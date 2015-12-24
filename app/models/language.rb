class Language < ActiveRecord::Base

  has_many :codeforces_round_solutions

  validates :name, presence: true
  validates :extension, presence: true

  # Returns all extensions of Languages.
  # ex> If extensions are 'java', 'c', 'cpp', this method will return
  # '.java,.c,.cpp'
  def Language.get_all_extensions_concat
    Language.all.map(&:extension).map{ |x| x = '.' + x }.join(',')
  end

end
