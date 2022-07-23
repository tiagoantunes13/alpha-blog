
class User < ApplicationRecord

  before_save { self.email.downcase!}

  has_many :articles

  validates :username, presence: true,
            length: {minimum: 3, maximum: 25},
            uniqueness: {case_sensitive: false}


  validates :email, presence: true,
            length: {maximum: 105},
            uniqueness: {case_sensitive: false},
            format: {with: URI::MailTo::EMAIL_REGEXP}

  has_secure_password
end