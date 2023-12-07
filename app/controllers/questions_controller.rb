# frozen_string_literal: true

class QuestionsController < ApplicationController
  include QuestionsAnswers
  include Vieweable

  before_action :set_question, only: %i[show edit update destroy like unlike]
  before_action :set_like, only: %i[like unlike]
  before_action :require_authentication, except: %i[index show]
  before_action :authorize_question!
  after_action :verify_authorized

  def like
    current_user.likes.create(likeable: @question) unless @like

    respond_to do |format|
      format.html { redirect_to questions_path }

      format.turbo_stream
    end
  end

  def unlike
    @like&.destroy

    respond_to do |format|
      format.html { redirect_to questions_path }

      format.turbo_stream
    end
  end

  def index
    @pagy, @questions = pagy(Question.all_by_tags(params), link_extra: 'data_turbo_frame="pagination_pagy"')
    @questions = @questions.decorate
  end

  def show
    load_questions_answers(do_render: false)
    mark_view(@question)
  end

  def new
    @question = Question.new
    @tags = Tag.all
  end

  def edit; end

  def create
    @question = current_user.questions.build question_params

    if @question.save
      respond_to do |format|
        format.html do
          flash[:success] = t '.success'
          redirect_to questions_path
        end

        format.turbo_stream do
          flash.now[:success] = t '.success'
          @question = @question.decorate
        end
      end
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      respond_to do |format|
        format.html do
          flash[:success] = t '.success'
          redirect_to questions_path
        end

        format.turbo_stream do
          flash.now[:success] = t '.success'
          @question = @question.decorate
        end
      end
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html do
        flash[:success] = t '.success'
        redirect_to questions_path
      end

      format.turbo_stream { flash.now[:success] = t '.success' }
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def set_like
    @like = current_user.likes.find_by(likeable: @question)
  end

  def question_params
    params.require(:question).permit(:title, :body, tag_ids: [])
  end

  def authorize_question!
    authorize(@question || Question)
  end
end
