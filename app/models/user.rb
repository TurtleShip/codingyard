class User < ActiveRecord::Base

  PER_PAGE = 10 # Number of users to display per page during pagination

  VALID_USERNAME_REGEX = /\A[A-Za-z0-9_-]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A['\w\s-]*\z/

  attr_accessor :remember_token, :activation_token, :reset_token

  has_many :top_coder_srm_solutions, dependent: :destroy
  has_many :codeforces_round_solutions, dependent: :destroy
  has_many :uva_solutions, dependent: :destroy

  validates :username, presence: true, uniqueness: {case_sensitive: false},
            format: {with: VALID_USERNAME_REGEX},
            length: {in: 3..20}

  validates :email, presence: true, uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX},
            length: {in: 3..50}

  validates :firstname, presence: false, uniqueness: false, format: {with: VALID_NAME_REGEX}
  validates :lastname, presence: false, uniqueness: false, format: {with: VALID_NAME_REGEX}
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  after_create :create_activation_digest

  acts_as_voter
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
  def authenticated?(attribute, token)
    # This is metaprogramming ( a programming writing a program)
    # It is equivalent to calling self.attribute_digest
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Creates reset digest
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token),
                   reset_sent_at: Time.zone.now )
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    # Is password reset sent EARLIER than two ours ago?
    reset_sent_at < 2.hours.ago
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token = User.new_token
    self.update_attribute(:activation_digest, User.digest(activation_token))
  end

  def sync_solution_count
    self.update_attribute(:solutions_count,
                          top_coder_srm_solutions.count + uva_solutions.count + codeforces_round_solutions.count)
  end

end
