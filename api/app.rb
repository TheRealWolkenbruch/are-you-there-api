# frozen_string_literal: true

require 'roda'
require 'sequel'
require 'sequel/plugins/json_serializer'
Dir['../models/*'].each { |file| require_relative file }

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
    r.on "are_you_there", String do |url_stub_id|
      r.get do
        require 'pry'; binding.pry
        bond = ::Bond.where(url_stub_id: url_stub_id)     
        if bond.nil?
          response.status = 404
          response.write({ error: 'Bond not found' }.to_json)
          r.halt
        end
        bond.update(seen_at: Time.now)

        { response: 'You are marked as are you there.' }.to_json
      end
    end

    r.on "api" do
      r.rodauth
      rodauth.require_authentication
      r.multi_route
    end
  end
end
require_relative 'routes/wards'
