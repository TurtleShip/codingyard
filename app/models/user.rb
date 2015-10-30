class User < ActiveRecord::Base

  VALID_USERNAME_REGEX = /\A[A-Za-z0-9_-]+\z/i

  validates :username, presence: true, allow_nil: false, uniqueness: true,
            format: {with: VALID_USERNAME_REGEX},
            length: {in: 3..20}

end
