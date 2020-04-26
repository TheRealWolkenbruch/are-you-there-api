source 'https://rubygems.org'
ruby File.read('./.tool-versions').match('ruby.*')[0].delete('ruby ')

gem 'sequel'
gem 'sequel-fixture'
gem 'sequel-annotate'
gem 'sqlite'
gem 'sqlite3'
gem 'rake'
gem 'roda', '~> 3.31'
gem 'rodauth'
gem 'bcrypt'
gem 'jwt'

gem 'puma'
gem 'rack-unreloader'

group :development do
  gem 'pry'
end

group :test do
  gem 'capybara'
  gem 'minitest', '>= 5.7.0'
  gem 'minitest-hooks', '>= 1.1.0'
  gem "minitest-global_expectations"
end
