# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_no_authentication, except: %i[destroy]
  before_action :require_authentication, only: :destroy

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate params[:password]
      sign_in user
      remember(user) if params[:remember_me] == '1'
      flash[:success] = "Welcome back, #{current_user.name_or_email}!"
      redirect_to questions_path
    else
      flash.now[:warning] = 'Incorrent e-mail or password!'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    flash[:success] = 'See you later!'
    redirect_to questions_path
  end
end
