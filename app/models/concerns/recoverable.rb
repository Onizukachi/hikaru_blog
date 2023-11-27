module Recoverable
  extend ActiveSupport::Concern

  included do
    before_update :clear_reset_password_token, if: :password_digest_changed?

    def set_reset_password_token
      update reset_password_token: digest(SecureRandom.urlsafe_base64), reset_password_token_sent_at: Time.current
    end

    def reset_password_period_valid?
      (reset_password_token_sent_at.present? && Time.current - reset_password_token_sent_at) <= 60.minutes
    end

    def clear_reset_password_token
      self.reset_password_token = nil
      self.reset_password_token_sent_at = nil
    end
  end
end
