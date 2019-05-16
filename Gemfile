source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Standard Rails Gems
ruby '2.4.1'
gem 'rails', '~> 5.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
# gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bcrypt', '~> 3.1.7'

gem 'webpacker', '~> 3.5'

# Custom Gems
gem 'active_model_serializers'
gem 'acts-as-taggable-on', '~> 6.0'
gem 'factory_bot_rails'
gem 'faker'
gem 'faraday'
gem 'figaro'
gem 'google-api-client'
gem 'jquery'
gem 'omniauth-github', github: 'intridea/omniauth-github'
gem 'omniauth-census', git: "https://github.com/turingschool-projects/omniauth-census"
gem 'rubocop-performance'
gem 'will_paginate'
gem 'yt', '~> 0.29.1'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'chromedriver-helper'
  gem 'database_cleaner'
  gem 'foundation-rails'
  gem 'launchy'
  gem 'mailcatcher'
  gem 'pry'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
