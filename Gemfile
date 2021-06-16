source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'pg', '~> 1.2.3'
gem 'pg_search'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0' # transpiles javascript
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'redis'
gem 'will_paginate'
gem 'devise'
gem 'image_processing'
gem 'bootsnap', '>= 1.4.2', require: false # reduces boot time via caching
gem 'validates_timeliness'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker'
  gem 'guard'
  gem 'guard-minitest'
end

group :development do
  gem 'web-console', '>= 3.3.0' #  console on exception pages
  gem 'listen', '~> 3.2'
  gem 'spring' # Runs app in bg for dev speed
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'rails-controller-testing'
  gem 'minitest'
  gem 'minitest-reporters'
end