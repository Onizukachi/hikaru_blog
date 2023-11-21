# frozen_string_literal: true

module Answers
  class CommentsController < ::CommentsController
    before_action :set_commentable, :set_question

    private

    def set_commentable
      @commentable = Answer.find params[:answer_id]
    end

    def set_question
      @question = @commentable.question
    end
  end
end
