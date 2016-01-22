module Solution
  extend ActiveSupport::Concern

  included do
    belongs_to :user, counter_cache: true
    belongs_to :contest
    belongs_to :language

    validates :user_id, presence: true
    validates :contest_id, presence: true
    validates :language_id, presence: true

    before_validation :assign_contest

    after_create :sync_solutions_count
    after_destroy :sync_solutions_count

    acts_as_votable
  end

  class_methods do
    def self.default_contest
      raise NotImplementedError
    end
  end

  def create_save_path(file)
    raise NotImplementedError
  end

  private

    def assign_contest
      self.contest = self.class.default_contest
    end

    def sync_solutions_count
      self.user.sync_solution_count
    end

end