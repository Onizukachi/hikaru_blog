# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :require_no_authentication
  before_action :check_user_params, only: %i[edit update]
  before_action :set_user, only: %i[edit update]

  def new; end

  def edit; end

  def create
    user = User.find_by(email: params[:email])

    if user.present?
      user.set_reset_password_token
      PasswordResetMailer.with(user:).reset_email.deliver_now
      flash[:success] = 'Instuctions was sent to your email'
      redirect_to new_session_path
    else
      flash.now[:warning] = 'There is no user with such email'
      render :new
    end
  end

  def update
    if @user.update user_params
      flash[:success] = 'You have successfully reset your password'
      redirect_to new_session_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:editable_user).permit(:password, :password_confirmation)
  end

  def check_user_params
    redirect_to(new_session_path, flash: { warning: 'Failed to reset password' }) if params[:editable_user].blank?
  end

  def set_user
    @user = EditableUser.find_by email: params[:editable_user][:email],
                         reset_password_token: params[:editable_user][:reset_password_token]

    redirect_to new_session_path, flash: { warning: 'Failed to reset password' } unless @user&.reset_password_period_valid?
  end
end
