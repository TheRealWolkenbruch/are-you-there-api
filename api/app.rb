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
    r.on "are_you_there", String do |url_stub_id|
      r.get do
        bond = ::Bond.where(url_stub_id: url_stub_id).first
        if bond.nil?
          response.status = 404
          response.write("<h1>Sorry, I don't know what you mean </h1>")
          r.halt
        end
        bond.update(seen_at: Time.now)

        r.redirect "https://app.areyouthere.de/#{url_sub_id}"
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
