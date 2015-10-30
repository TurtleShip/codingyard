class User < ActiveRecord::Base

  VALID_USERNAME_REGEX = /\A[A-Za-z0-9_-]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, allow_nil: false, uniqueness: true,
            format: {with: VALID_USERNAME_REGEX},
            length: {in: 3..20}

  validates :email, presence: true, allow_nil: false, uniqueness: true,
            format: {with: VALID_EMAIL_REGEX},
            length: {in: 3..50}

  before_save :downcase_email

  def downcase_email
    email.downcase!
  end
end
