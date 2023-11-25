# frozen_string_literal: true

class QuestionsController < ApplicationController
  include QuestionsAnswers
  before_action :set_question, only: %i[show edit update destroy]
  before_action :require_authentication, except: %i[index show]
  before_action :authorize_question!
  after_action :verify_authorized

  def index
    @pagy, @questions = pagy Question.all_by_tags params
    @questions = @questions.decorate
  end

  def show
    load_questions_answers(do_render: false)
  end

  def new
    @question = Question.new
    @tags = Tag.all
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
    params.require(:question).permit(:title, :body, tag_ids: [])
  end

  def authorize_question!
    authorize(@question || Question)
  end
end
