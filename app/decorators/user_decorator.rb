# frozen_string_literal: true

class UserDecorator < Draper::Decorator
  delegate_all

  def name_or_email
    return name if name.present?

    email.split('@').first
  end
end
