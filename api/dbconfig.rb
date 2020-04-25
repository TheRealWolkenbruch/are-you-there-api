require 'bcrypt'
require 'sequel'

DB = Sequel.sqlite("are-you-there_#{ENV['RACK_ENV']}.db")
