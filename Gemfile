# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.4'

# Database
gem 'pg', '~> 1.1'

# Server
gem 'bootsnap', '>= 1.4.4', require: false
gem 'puma', '~> 5.0'

# Authentication and authorization
gem 'devise'

# Serialization
gem 'blueprinter'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Linting
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

    # Testing
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
end
