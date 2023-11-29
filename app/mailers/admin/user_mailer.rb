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

      mail(to: @user.email, subject: 'User Import task failed')
    end
  end
end
