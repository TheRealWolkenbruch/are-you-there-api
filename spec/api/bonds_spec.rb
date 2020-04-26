# frozen_string_literal: true

require_relative 'spec_helper'

describe 'bonds' do
  include Rack::Test::Methods
  before do
    header 'Content-Type', 'application/json'
    post '/login', '{"login": "john@doe.com", "password": "JohnDoe1"}'
    header 'Authorization', last_response.headers['Authorization']    
  end
  it 'works' do
    get '/api/bonds'
    assert_equal 200, last_response.status
    response = JSON.parse(last_response.body)
    assert_equal 1, response.size
    assert_equal "ward1@google.com", response[0]["email"]
  end
end
