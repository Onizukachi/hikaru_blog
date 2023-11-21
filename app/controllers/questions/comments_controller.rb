# frozen_string_literal: true

module Questions
  class CommentsController < ::CommentsController
    before_action :set_commentable, :set_question

    private

    def set_commentable
      @commentable = Question.find params[:question_id]
    end

    def set_question
      @question = @commentable
    end
  end
end
