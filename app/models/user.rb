# frozen_string_literal: true

class User < ApplicationRecord
  include Recoverable
  include Rememberable

  enum :role, { basic: 0, moderator: 1, admin: 2 }, suffix: :role
  attr_accessor :old_password, :remember_token

  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_secure_password validations: false

  validate :password_presence
  validate :correct_old_password, on: :update, if: -> { validate_correct_old_password? }
  validates :password, confirmation: true, allow_blank: true, length: { minimum: 8, maximum: 70 }
  validate :password_complexity

  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true

  before_save :set_gravatar_hash, if: :email_changed?

  def ban_status
    is_banned ? 'banned' : 'not banned'
  end

  def ban
    update(is_banned: true) if basic_role?
  end

  def unban
    update(is_banned: false) if basic_role?
  end

  def author?(obj)
    self == obj.user
  end

  def guest?
    false
  end

  private

  def set_gravatar_hash
    return if email.blank?

    hash = Digest::MD5.hexdigest email.strip.downcase
    self.gravatar_hash = hash
  end

  def digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, 'is incorrect'
  end

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /.+/ # /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/

    msg = 'Complexity requirement not met. Length should be 8-70 characters and ' \
          'include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
    errors.add :password, msg
  end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end

  def validate_correct_old_password?
    password.present? || email_changed?
  end
end
