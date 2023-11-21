# frozen_string_literal: true

class CommentsController < ApplicationController
  include QuestionsAnswers

  def create
    @comment = @commentable.comments.build comment_params

    if @comment.save
      flash[:success] = 'Comment was created!'
      redirect_to question_path @question
    else
      load_questions_answers(do_render: true)
    end
  end

  def destroy
    comment = @commentable.comments.find params[:id]
    comment.destroy

    flash[:success] = 'Comment was deleted!'
    redirect_to question_path @commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end
end
