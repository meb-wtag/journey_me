source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'bootsnap', require: false
gem 'bootstrap', '~> 5.3.1'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.7'
gem 'rails-i18n', '~> 7.0.7'
gem 'i18n-tasks', '~> 1.0.12'
gem 'rails-controller-testing'
gem 'sprockets-rails'
gem 'simple_form'
gem 'stimulus-rails'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'turbo-rails'

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 6.0.0'
  gem 'factory_bot_rails'
  gem 'ffaker'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'shoulda-matchers', '~> 5.0'
end
