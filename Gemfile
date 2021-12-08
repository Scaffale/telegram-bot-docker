source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

gem 'pg'
gem 'puma'
# Use Redis adapter to run Action Cable in production
gem 'bootsnap'
gem 'dotenv-rails'
gem 'parallel'
gem 'redis'
gem 'ruby-progressbar'
gem 'slim'
gem 'telegram-bot'
gem 'whenever', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-rails'
end

group :development do
  gem 'better_errors'
  gem 'listen'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner-active_record'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
