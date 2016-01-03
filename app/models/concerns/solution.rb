module Solution
  extend ActiveSupport::Concern

  included do
    belongs_to :user, counter_cache: true
    belongs_to :contest
    belongs_to :language

    validates :user_id, presence: true
    validates :contest_id, presence: true
    validates :language_id, presence: true

    after_create :increment_solutions_counter
    after_destroy :decrement_solutions_counter

    acts_as_votable
  end

  def self.new_with_relations(params, user, language)
    raise NotImplementedError
  end

  def create_save_path(file)
    raise NotImplementedError
  end

  def increment_solutions_counter
    user.solutions_count += 1
  end

  def decrement_solutions_counter
    user.solutions_count -= 1
  end

end