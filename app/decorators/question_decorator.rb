# frozen_string_literal: true

class QuestionDecorator < Draper::Decorator
  delegate_all

  def formatted_created_at
    l created_at, format: :long
  end
end
