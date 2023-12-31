# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_no_authentication, except: %i[destroy]
  before_action :require_authentication, only: :destroy
  before_action :set_user, only: :create

  def new; end

  def create
    if @user&.authenticate params[:password]
      sign_in @user
      remember(@user) if params[:remember_me] == '1'
      flash[:success] = "Welcome back, #{current_user.name_or_email}!"
      redirect_to questions_path
    else
      flash.now[:warning] = 'Incorrent e-mail or password!'

      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }

        format.turbo_stream
      end
    end
  end

  def destroy
    sign_out
    flash[:success] = 'See you later!'
    redirect_to questions_path
  end

  private

  def set_user
    @user = User.find_by(email: params[:email])
  end
end
