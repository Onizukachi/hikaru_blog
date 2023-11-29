# frozen_string_literal: true

class UserBulkExportService < ApplicationService
  attr_reader :archive_key, :service

  def call
    render_class = ActionController::Base.new

    compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      User.order(created_at: :desc).each do |user|
        zos.put_next_entry "user_#{user.id}.xlsx"

        zos.print render_class.render_to_string(layout: false, handlers: [:axlsx], formats: [:xlsx],
                                                template: 'admin/users/user', locals: { user: })
      end
    end

    compressed_filestream.rewind

    ActiveStorage::Blob.create_and_upload! io: compressed_filestream, filename: 'users.zip'
  end
end
