# frozen_string_literal: true

require 'roda'
require 'sequel'
require 'sequel/plugins/json_serializer'

require_relative 'dbconfig'
class App < Roda
  plugin :rodauth, json: :only do
    enable :login, :logout, :jwt, :create_account
    jwt_secret 'superinsecure'
    db DB
    accounts_table :guardians
    account_password_hash_column :password
    require_login_confirmation? false

    before_create_account do
      account[:name] = param('name')
    end
  end
  plugin :multi_route
  route do |r|
    r.rodauth
    rodauth.require_authentication
    r.on "api" do
      r.multi_route
    end
  end
end
require_relative 'routes/wards'
