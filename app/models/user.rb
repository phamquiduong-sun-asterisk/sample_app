class User < ApplicationRecord
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: {maximum: Settings.user.email.max},
  format: {with: VALID_EMAIL_REGEX}
  validates :email, uniqueness: true
  has_secure_password

  before_save :downcase_all

  private

  def downcase_all
    email.downcase!
  end
end
