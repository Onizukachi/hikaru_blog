# frozen_string_literal: true

module Admin
  class UserMailer < ApplicationMailer
    def bulk_import_done
      @user = params[:user]

      mail(to: @user.email, subject: 'User Import task ')
    end

    def bulk_import_fail
      @error = params[:error]
      @user = params[:user]

      mail(to: @user.email, subject: 'User Import task')
    end

    def bulk_export_done
      @user = params[:user]
      zip_blob = params[:archive]
      attachments[zip_blob.attachable_filename] = zip_blob.download
      mail(to: @user.email, subject: 'User Export Task')
    end
  end
end
