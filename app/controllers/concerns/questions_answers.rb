# frozen_string_literal: true

module QuestionsAnswers
  extend ActiveSupport::Concern

  included do
    private

    def load_questions_answers(do_render: false)
      @comments = CommentDecorator.decorate_collection @commentable.comments.order(created_at: :desc)
      @question = @question.decorate
      @answer ||= @question.answers.build
      @pagy, @answers = pagy(@question.answers.order(created_at: :desc), items: 5)
      @answers = @answers.decorate
      render('questions/show', status: :unprocessable_entity) if do_render
    end
  end
end
