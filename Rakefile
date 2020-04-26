require 'rubygems'
require 'bundler/setup'

require 'sqlite'
require 'sequel'
require 'logger'

def self.migrate(version)
  Sequel.extension :migration
  db = Sequel.sqlite("are-you-there_#{ENV['RACK_ENV']}.db")
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
  desc "Annotate Sequel models"
  task "annotate" do
    ENV['RACK_ENV'] = 'development'
    require_relative 'models'
    DB.loggers.clear
    require 'sequel/annotate'
    Sequel::Annotate.annotate(Dir['models/*.rb'])
  end
end
namespace :data do
  desc 'Insert fixtures'
  task :fixtures do
    require "sequel-fixture"
    DB = Sequel.sqlite("are-you-there_#{ENV['RACK_ENV']}.db")
    Sequel::Fixture.path = File.join(File.dirname(__FILE__), "fixtures")
    fixture1 = Sequel::Fixture.new :simple1, DB # Will load all the data in the fixture into the database
    fixture2 = Sequel::Fixture.new :simple2, DB # Will load all the data in the fixture into the database
    fixture3 = Sequel::Fixture.new :simple3, DB # Will load all the data in the fixture into the database
    fixture4 = Sequel::Fixture.new :simple4, DB # Will load all the data in the fixture into the database
  end
end
