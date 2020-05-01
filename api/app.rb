# frozen_string_literal: true

require 'roda'
require 'sequel'
require 'sequel/plugins/json_serializer'

require_relative 'dbconfig'

Dir["#{Dir.pwd}/models/*.rb"].sort.each { |file| require file }

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

    r.on 'bond' do
      r.route 'bond'
    end

    r.on 'api' do
      rodauth.require_authentication
      r.multi_route('auth_api')
    end
  end
end
require_relative 'routes/wards'
require_relative 'routes/bonds'
