# frozen_string_literal: true

class UserDecorator < Draper::Decorator
  delegate_all

  def name_or_email
    return name if name.present?

    email.split('@').first
  end

  def formated_created_at
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  def formated_updated_at
    updated_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
