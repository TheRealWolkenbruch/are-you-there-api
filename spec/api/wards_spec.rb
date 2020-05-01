# frozen_string_literal: true

require_relative 'spec_helper'

# Tests with guardian logged in
describe 'access wards with guardian ID' do
  include Rack::Test::Methods
  before do
    header 'Content-Type', 'application/json'
    post '/login', '{"login": "john@doe.com", "password": "JohnDoe1"}'
    header 'Authorization', last_response.headers['Authorization']
  end
  it 'get wards' do
    get '/api/wards'
    assert_equal 200, last_response.status
    response = JSON.parse(last_response.body)
    assert_equal 1, response.size
    assert_equal 'ward1@google.com', response[0]['email']
    assert_nil response[0]['password']
  end
  it 'needs parameters' do
    post '/api/wards/create'
    assert_equal 400, last_response.status
  end
  it 'needs all parameters' do
    bad_ward = { 'human_readable_name' => 'Patty Smith' }
    post '/api/wards/create', bad_ward.to_json
    assert_equal 400, last_response.status
  end
  it 'needs all parameters filled in' do
    incomplete_ward = { 'human_readable_name' => 'Patty Smith',
                        'contactdata' => 'short address',
                        'email' => nil, 'password' => '1234' }
    post '/api/wards/create', incomplete_ward.to_json
    assert_equal 400, last_response.status
  end
  it 'returns ward id on successful creation' do
    complete_ward = { 'human_readable_name' => 'Patty Smith',
                      'contactdata' => 'short address',
                      'email' => 'patty@smith.com', 'password' => '1234' }
    post '/api/wards/create', complete_ward.to_json
    assert_equal 200, last_response.status
    response = JSON.parse(last_response.body)
    assert_equal 3, response['ward_id']
    new_ward = Ward[id: 3]
    assert_equal 'Patty Smith', new_ward[:human_readable_name]
    assert_equal 1, new_ward[:f_guardian_id]
    assert_equal '$', new_ward[:password][0]
  end
  it 'deletes wards' do
    assert_equal 2, Ward.count
    id_to_delete = { 'ward_id': 1 }
    post '/api/wards/delete', id_to_delete.to_json
    assert_equal 200, last_response.status
    response = JSON.parse(last_response.body)
    assert_equal 'Ward 1 was marked as deleted.', response['success']
    # Ward record is not actually deleted
    assert_equal 2, Ward.count
    assert Ward[id: 1].deleted
  end
end
