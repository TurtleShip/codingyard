class User < ActiveRecord::Base

  has_many :top_coder_srm_solutions, dependent: :destroy
  has_many :codeforces_round_solutions, dependent: :destroy

  VALID_USERNAME_REGEX = /\A[A-Za-z0-9_-]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A[\w\s-]*\z/

  validates :username, presence: true, uniqueness: {case_sensitive: false},
            format: {with: VALID_USERNAME_REGEX},
            length: {in: 3..20}

  validates :email, presence: true, uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX},
            length: {in: 3..50}

  validates :firstname, presence: false, uniqueness: false, format: {with: VALID_NAME_REGEX}
  validates :lastname, presence: false, uniqueness: false, format: {with: VALID_NAME_REGEX}
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  before_save :downcase_email
  before_save :downcase_username

  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private
    def downcase_username
      username.downcase!
    end

    def downcase_email
      email.downcase!
    end

end
