# frozen_string_literal: true

require 'bcrypt'
require 'sequel'

DB = Sequel.sqlite(File.join('db',"are-you-there_#{ENV['RACK_ENV']}.db"))
