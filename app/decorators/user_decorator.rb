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

  def gravatar(size: 30, css_class: '')
    h.image_tag "https://gravatar.com/avatar/#{gravatar_hash}.jpg?s=#{size}", class: "rounded #{css_class}",
                                                                              alt: name_or_email
  end
end
