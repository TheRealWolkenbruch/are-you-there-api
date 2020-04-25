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
  plugin :hash_routes
  hash_path "/api/wards" do |r|
    wards(r)
  end
  route do |r|
    r.rodauth
    rodauth.require_authentication
    r.hash_routes
  end
end
require_relative 'wards'
