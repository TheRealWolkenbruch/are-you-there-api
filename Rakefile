require 'rubygems'
require 'bundler/setup'

require 'sqlite'
require 'sequel'
require 'logger'

def self.migrate(env, version)
  ENV['RACK_ENV'] = env

  Sequel.extension :migration
  db = Sequel.sqlite('are-you-there.db')
  db.loggers << Logger.new($stdout) if db.loggers.empty?
  Sequel::Migrator.apply(db, 'migrations', version)
end

namespace :db do
  desc 'Migrate database to last version'
  task :migrate do
    migrate('development', nil)
  end

  desc 'Rollback database to position one'
  task :rollback, [:version] do |t, args|
    version = args[:version].to_i || 0
    migrate('development', version)
  end
end
