# frozen_string_literal: true

module Admin
  class UsersController < BaseController
    before_action :require_authentication
    before_action :set_user, only: %i[edit update destroy ban unban]
    before_action :authorize_user!
    after_action :verify_authorized

    def index
      respond_to do |format|
        format.html do
          @pagy, @users = pagy(User.order(created_at: :desc), items: 8)
          @users = @users.decorate
        end

        format.zip { respond_with_zipped_users }
      end
    end

    def edit; end

    def create
      if params[:archive].present?
        UserBulkService.call params[:archive]
        flash[:success] = 'Users Imported!'
      end

      redirect_to admin_users_path
    end

    def update
      if @user.update user_params
        flash[:success] = 'User was successfully updated!'
        redirect_to admin_users_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy

      flash[:success] = 'User was deleted!'
      redirect_to admin_users_path
    end

    def ban
      @user.ban
      flash[:success] = "User #{@user.decorate.name_or_email} was banned!"
      redirect_to admin_users_path
    end

    def unban
      @user.unban
      flash[:success] = "User #{@user.decorate.name_or_email} was unbanned!"
      redirect_to admin_users_path
    end

    private

    def set_user
      @user = EditableUser.find(params[:id])
    end

    def user_params
      params.require(:editable_user).permit(:email, :name, :password, :password_confirmation, :old_password, :role)
    end

    def respond_with_zipped_users
      zip_stream = Zip::OutputStream.write_buffer do |zos|
        User.order(created_at: :desc).each do |user|
          zos.put_next_entry "user_#{user.id}.xlsx"

          zos.print render_to_string(layout: false, handlers: [:axlsx], formats: [:xlsx],
                                     template: 'admin/users/user', locals: { user: })
        end
      end

      zip_stream.rewind
      send_data zip_stream.read, filename: 'users.zip'
    end

    def authorize_user!
      authorize(@user || EditableUser)
    end
  end
end
