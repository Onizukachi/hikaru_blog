# frozen_string_literal: true

module QuestionsAnswers
  extend ActiveSupport::Concern

  included do
    private

    def load_questions_answers(do_render: false)
      @question = @question.decorate
      @pagy, @answers = pagy @question.answers.includes(:comments, :user).order(created_at: :desc)
      @answer ||= @question.answers.build
      @answers = @answers.decorate
      render('questions/show', status: :unprocessable_entity) if do_render
    end
  end
end
