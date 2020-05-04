# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read('./.tool-versions').match('ruby.*')[0].delete('ruby ')

gem 'bcrypt'
gem 'jwt'
gem 'rake'
gem 'roda', '~> 3.31'
gem 'roda-route_list'
gem 'rodauth'
gem 'sequel'
gem 'sequel-annotate'
gem 'sequel-fixture'
gem 'sqlite3'

gem 'puma'
gem 'rack-unreloader'

group :development do
  gem 'pry'
  gem 'pry-byebug'
  gem 'rubocop'
end

group :test do
  gem 'capybara'
  gem 'minitest', '>= 5.7.0'
  gem 'minitest-global_expectations'
  gem 'minitest-hooks', '>= 1.1.0'
end
