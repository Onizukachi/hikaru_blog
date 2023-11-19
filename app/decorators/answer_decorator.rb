# frozen_string_literal: true

class AnswerDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def formatted_created_at
    l created_at, format: :long
  end

  def owner
    'Unknown'
  end
end
