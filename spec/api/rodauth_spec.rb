# frozen_string_literal: true

require_relative 'spec_helper'

describe 'rodaauth' do
  include Rack::Test::Methods
  it 'requires authentication' do
    get '/api/wards'
    assert_equal 400, last_response.status
  end
  it 'login correctly' do
    header 'Content-Type', 'application/json'
    post '/login', '{"login": "john@doe.com", "password": "JohnDoe1"}'
    assert_equal 200, last_response.status
    assert_includes last_response.headers.keys, 'Authorization'
    header 'Authorization', last_response.headers['Authorization']
    get '/api/wards'
    assert_equal 200, last_response.status
    response = JSON.parse(last_response.body)
    assert_equal 'Ward One', response[0]['human_readable_name']
  end
  it 'doesnt login without password' do
    header 'Content-Type', 'application/json'
    post '/login', '{"login": "john@doe.com", "password": "Forgotten"}'
    assert_equal 400, last_response.status
  end
end
