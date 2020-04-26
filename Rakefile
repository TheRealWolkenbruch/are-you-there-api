require 'rubygems'
require 'bundler/setup'

require 'sqlite'
require 'sequel'
require 'logger'
require_relative 'api/dbconfig'

def self.migrate(version)
  Sequel.extension :migration
  DB.loggers << Logger.new($stdout) if DB.loggers.empty?
  Sequel::Migrator.apply(DB, 'migrations', version)
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
    rack_env_missing
    require_relative 'annotator'
    DB.loggers.clear
    require 'sequel/annotate'
    Sequel::Annotate.annotate(Dir['models/*.rb'])
  end
end
namespace :data do
  desc 'Insert fixtures'
  task :fixtures do
    rack_env_missing
    require "sequel-fixture"
    Sequel::Fixture.path = File.join(File.dirname(__FILE__), "fixtures")
    Sequel::Fixture.new :simple1, DB # Will load all the data in the fixture into the database
    Sequel::Fixture.new :simple2, DB # Will load all the data in the fixture into the database
    Sequel::Fixture.new :simple3, DB # Will load all the data in the fixture into the database
    Sequel::Fixture.new :simple4, DB # Will load all the data in the fixture into the database
  end
end
spec = proc do |pattern|
  sh "#{FileUtils::RUBY} -e 'ARGV.each{|f| require f}' #{pattern}"
end
namespace :tests do
  desc "Run web specs"
  task :api do
    spec.call('./spec/api/*_spec.rb')
  end
end
namespace :assets do
  desc "Update the routes metadata"
  task :precompile do
    sh 'grep -rh "# route" api > routes.tmp'
    sh 'roda-parse_routes -f routes.json routes.tmp'
  end
end
