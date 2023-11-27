# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'hikaru_blog@example.com'
  layout 'mailer'
end
