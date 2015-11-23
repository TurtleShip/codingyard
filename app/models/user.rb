class User < ActiveRecord::Base

  PER_PAGE = 10 # Number of users to display per page during pagination

  VALID_USERNAME_REGEX = /\A[A-Za-z0-9_-]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A['\w\s-]*\z/

  attr_accessor :remember_token, :activation_token

  has_many :top_coder_srm_solutions, dependent: :destroy
  has_many :codeforces_round_solutions, dependent: :destroy

  validates :username, presence: true, uniqueness: {case_sensitive: false},
            format: {with: VALID_USERNAME_REGEX},
            length: {in: 3..20}

  validates :email, presence: true, uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX},
            length: {in: 3..50}

  validates :firstname, presence: false, uniqueness: false, format: {with: VALID_NAME_REGEX}
  validates :lastname, presence: false, uniqueness: false, format: {with: VALID_NAME_REGEX}
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  before_create :create_activation_digest
  before_save :downcase_email
  before_save :downcase_username

  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  private
    def downcase_username
      username.downcase!
    end

    def downcase_email
      email.downcase!
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
