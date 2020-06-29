class User < ApplicationRecord
  before_save :downcase_email
  enum role: %i[user employe admin]
  has_secure_password
  has_many :appointments
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }

  validates_presence_of :phone

  private

  def downcase_email
    email.downcase!
  end
end
