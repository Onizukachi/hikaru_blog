# frozen_string_literal: true

class UserBulkExportJob < ApplicationJob
  queue_as :default

  def perform(initiator)
    zipped_blob = UserBulkExportService.call
    Admin::UserMailer.with(archive: zipped_blob, user: initiator).bulk_export_done.deliver_now
  ensure
    zipped_blob.purge
  end
end
