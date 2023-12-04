# frozen_string_literal: true

class CommentsController < ApplicationController
  include QuestionsAnswers
  after_action :verify_authorized

  def create
    @comment = @commentable.comments.build comment_params
    authorize @comment

    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = 'Comment was created!'
          redirect_to question_path @question
        end

        format.turbo_stream do
          flash.now[:success] = 'Comment was created!'
          @comment = @comment.decorate
          @comment_count = @commentable.comments.size
        end
      end

    else
      @comment = @comment.decorate
      load_questions_answers(do_render: true)
    end
  end

  def destroy
    @comment = @commentable.comments.find params[:id]
    authorize @comment
    @comment.destroy

    respond_to do |format|
      format.turbo_stream do
        flash.now[:success] = 'Comment was deleted!'
        @comment_count = @commentable.comments.size
      end

      format.html do
        flash[:success] = 'Comment was deleted!'
        redirect_to question_path @question
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end
end
