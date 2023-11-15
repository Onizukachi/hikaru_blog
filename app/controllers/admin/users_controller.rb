# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :require_authentication

    def index
      respond_to do |format|
        format.html do
          @pagy, @users = pagy(User.order(created_at: :desc), items: 8)
          @users = @users.decorate
        end

        format.zip { respond_with_zipped_users }
      end
    end

    def create
      if params[:archive].present?
        UserBulkService.call params[:archive]
        flash[:success] = 'Users Imported!'
      end

      redirect_to admin_users_path
    end

    private

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
  end
end
