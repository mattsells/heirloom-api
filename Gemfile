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
gem 'devise-jwt'
gem 'pundit'

# Serialization
gem 'blueprinter'
gem 'olive_branch'

# File storage
gem 'aws-sdk-s3', '~> 1.14'
gem 'shrine', '~> 3.0'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Image processing
gem 'image_processing', '~> 1.8'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # Testing
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false

  # Display schema in model files
  gem 'annotate'

  # Development env loading
  gem 'figaro'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Linting
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  # Protect against n+1 queries
  gem 'bullet'
end
