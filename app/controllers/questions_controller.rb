# frozen_string_literal: true

class QuestionsController < ApplicationController
  include QuestionsAnswers
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @pagy, @questions = pagy(Question.order(created_at: :desc), items: 15)
    @questions = @questions.decorate
  end

  def show
    @commentable = @question
    @comment = Comment.new
    load_questions_answers(do_render: false)
  end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = current_user.questions.build question_params

    if @question.save
      flash[:success] = t '.success'
      redirect_to questions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      flash[:success] = t '.success'
      redirect_to questions_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    flash[:success] = t '.success'
    redirect_to questions_path
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
