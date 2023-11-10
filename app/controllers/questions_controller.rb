class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  def index
    @questions = Question.order(id: :desc)
  end

  def show
    @answer = @question.answers.build
    @answers = @question.answers.order created_at: :desc
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create question_params

    if @question.save
      flash[:success] = 'Question Created!'
      redirect_to questions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      flash[:success] = 'Question Updated!'
      redirect_to questions_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    flash[:success] = 'Question Deleted!'
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
