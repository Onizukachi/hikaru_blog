class UserBulkService < ApplicationService
  attr_reader :archive

  def initialize(archive_param)
    @archive = archive_param.tempfile
  end

  def call
    Zip::File.open(@archive) do |zip_file|
      zip_file.each do |entry|
        User.import(user_from(entry), ignore: true)
      end
    end
  end

  private

  def user_from(entry)
    sheet = RubyXL::Parser.parse_buffer(entry.get_input_stream.read)[0]
    sheet.map do |row|
      cells = row.cells

      User.new name: cells[0]&.value.to_s,
               email: cells[1]&.value.to_s,
               password: cells[2]&.value.to_s,
               password_confirmation: cells[2]&.value.to_s
    end
  end
end