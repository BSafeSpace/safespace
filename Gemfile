source 'https://rubygems.org'
ruby '2.5.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', group: :doc
# SafeSpace Added Gems
  # Devise Tutorial  http://www.sitepoint.com/devise-authentication-in-depth/
  # Devise Demo      https://sitepoint-devise.herokuapp.com/
gem 'devise'
gem 'bootstrap-sass'
gem 'jquery-turbolinks'
gem 'codeclimate-test-reporter', group: :test, require: nil
# http://www.sitepoint.com/save-multiple-checkbox-values-database-rails/
  # Profile Characteristic Model Search
gem 'ransack'

#heroku gem to convert to postgres
gem 'private_pub'
gem 'taps'
# gem 'faye-rails', '~> 2.0'
gem 'thin'

# Pass Ruby Variables to JavaScript
gem 'gon'

gem 'jquery-ui-rails'

# PDF generator
gem 'prawn'

# Font Awesome icons
gem 'font-awesome-sass'
gem 'will_paginate'
gem "font-awesome-rails"

gem 'whenever', :require => false

gem 'simple_form'

# Typeform
gem 'ask_awesomely'

# For Making HTTP Requests. It's a party!
gem 'httparty'

# For updating the position attribute of resources
gem 'acts_as_list'

# For web content creation (tools for Peer Counselors creating resources)
gem 'ckeditor'

# For contact page
gem 'mail_form'

gem 'figaro'

group :production do
  # gem 'pg'
  # Better error logs on Heroku
  gem 'rails_12factor'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'capybara'
  gem 'factory_bot'
  gem 'sqlite3'
  gem 'foreman' # allow us to use our .env file by accessing the local variables before starting the application.
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
