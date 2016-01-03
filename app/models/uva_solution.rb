class UvaSolution < ActiveRecord::Base

  include Solution
  validates :problem_number, presence: true, numericality: {greater_than: 0}
  validates :original_link, length: {maximum: 255}
  validates :title, length: {maximum: 255}

  def UvaSolution.new_with_relations(params, user, language)
    solution = new(params)
    solution.user = user
    solution.contest = Contest.codeforces
    solution.language = language
    solution
  end

  def create_save_path(file)
    digest = Digest::MD5.hexdigest(file)
    path = "UVa/#{problem_number}/#{user.username}"
    path += "/#{Time.now.to_i}-#{digest}.#{language.extension}"
    path
  end

end
