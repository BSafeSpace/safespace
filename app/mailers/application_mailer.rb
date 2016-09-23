class ApplicationMailer < ActionMailer::Base
  default from: "notifications@safespace.com"
  layout 'mailer'
end
