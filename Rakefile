require 'rubygems'
# require 'bundler/setup'

require 'sqlite'
require 'sequel'

def self.migrate(env, version)
  ENV['RACK_ENV'] = env

  Sequel.extension :migration
  db = Sequel.sqlite('are-you-there.db')
  Sequel::Migrator.apply(db, 'migrations', version)
end

namespace :db do
  desc 'Migrate database to last version'
  task :migrate do
    migrate('development', nil)
  end

  desc 'Rollback database to position one'
  task :rollback do
    migrate('development', 0)
  end
end
