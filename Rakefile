require 'rubygems'
require 'bundler/setup'

require 'sqlite'
require 'sequel'
require 'logger'

def self.migrate(version)
  Sequel.extension :migration
  db = Sequel.sqlite(File.join('db',"are-you-there_#{ENV['RACK_ENV']}.db"))
  db.loggers << Logger.new($stdout) if db.loggers.empty?
  Sequel::Migrator.apply(db, 'migrations', version)
end

def self.rack_env_missing
  raise 'RACK_ENV not set' unless ENV['RACK_ENV']
end

namespace :db do
  desc 'Migrate database to last version'
  task :migrate do
    rack_env_missing
    migrate(nil)
  end

  desc 'Rollback database to position one'
  task :rollback, [:version] do |t, args|
    rack_env_missing
    version = args[:version].to_i || 0
    migrate(version)
  end
end
