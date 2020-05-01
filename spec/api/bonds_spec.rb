# frozen_string_literal: true

require_relative 'spec_helper'

# Tests with guardian logged in
describe 'access bonds with guardian ID' do
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

# Tests of bonds updates with UUID
describe 'update bonds with UUID' do
  include Rack::Test::Methods
  it 'rejects unknown UUIDs' do
    get '/bond/1222-112'
    assert_equal 404, last_response.status
  end
  it 'updates seen_at on visit' do
    bond_before = Bond[id: 2].seen_at
    previous_time = Time.now
    assert_nil bond_before
    get '/bond/0000-33EF'
    assert_nil bond_before
    assert_operator previous_time, :<=, Bond[id: 2].seen_at
  end
  it 'stores feedback message' do
    how_i_am = Bond[id: 2].feedback_message
    assert_nil how_i_am
    post '/bond/0000-33EF/update', {'feedback_message' => "I'm fine"}
    assert_equal "I'm fine", Bond[id: 2].feedback_message
    post '/bond/0000-33EF/update', {'feedback_message' => "Better than ever"}
    assert_equal "Better than ever", Bond[id: 2].feedback_message
  end
end