# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'haml-rails', '~> 2.0'
gem 'importmap-rails'
gem 'jbuilder'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.7'
gem 'sprockets-rails'
gem 'sqlite3', '~> 1.4'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-mocks'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'web-console'
end

# Run against this stable release
group :development, :test do
  gem 'rspec-rails', '~> 6.0.0'
end
