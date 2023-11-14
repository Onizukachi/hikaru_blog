class AnswerDecorator < Draper::Decorator
  delegate_all

  def formatted_created_at
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  def owner
    'Unknown'
  end
end
