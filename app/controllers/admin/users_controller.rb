# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :require_authentication

    def index
      @pagy, @users = pagy(User.order(created_at: :desc), items: 8)
      @users = @users.decorate

      respond_to do |format|
        format.html

        format.zip do
          zip_stream = Zip::OutputStream.write_buffer do |zip|
            @users.each do |user|
              zip.put_next_entry "#{user.id}_file.txt "
              xlsx = render_to_string layout: false, handlers: [:erb], formats: [:html], partial: 'admin/users/user',
                                      locals: { user: @users.first }
              zip.write xlsx
            end
          end

          zip_stream.rewind

          send_data zip_stream.read, filename: 'my_archieve.zip'
        end
      end
    end
  end
end
