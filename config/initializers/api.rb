# Configure Ask Awesomely Typeform API
require "ask_awesomely"
TYPEFORM_IO_API_KEY = ENV["TYPEFORM_IO_API_KEY"]
SENDGRID_API_KEY = ENV["SENDGRID_API_KEY"]
AskAwesomely.configure do |config|
  config.typeform_api_key = TYPEFORM_IO_API_KEY
end