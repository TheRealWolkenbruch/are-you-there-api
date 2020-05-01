# frozen_string_literal: true

class App < Roda
  WHITELIST_PARAMS = %w[human_readable_name contactdata email password].freeze

  route('wards', 'api') do |r|
    # route[List_wards]: /api/wards
    r.get do
      account_id = rodauth.jwt_session_hash[:account_id]
      DB[:wards].where(f_guardian_id: account_id).map do |ward|
        ward.reject { |k, _v| k == :password }
      end.to_json
    end

    r.on 'create' do
      # route[Create_ward]: POST /api/wards/create
      r.post do
        unless params_valid?(r.params)
          response.status = 400
          response.write({ error: 'Missing parameters or too many' }.to_json)
          r.halt
        end

        unless params_set?(r.params)
          response.status = 400
          response.write({ error: 'Not all params have a value' }.to_json)
          r.halt
        end

        account_id = rodauth.jwt_session_hash[:account_id]
        ward_id = create_ward(account_id, r.params)

        { ward_id: ward_id }.to_json
      end
    end

    r.post 'delete' do
      ward_id = r.params['ward_id']
      ward = Ward.find(id: ward_id)

      if ward.nil?
        response.status = 400
        response.write({ error: 'Ward not found.' })
        r.halt
      end

      ward.update(deleted: true)

      { success: "Ward #{ward_id} was marked as deleted." }
    end
  end

  def create_ward(account_id, params)
    DB[:wards].insert(f_guardian_id: account_id,
                      human_readable_name: params['human_readable_name'],
                      contactdata: params['contactdata'],
                      email: params['email'],
                      # MVP solution, guardian set password for ward.
                      password: BCrypt::Password.create(params['password']))
  end

  def params_valid?(params)
    params.keys.sort == WHITELIST_PARAMS.sort
  end

  def params_set?(params)
    params.values.compact.size == WHITELIST_PARAMS.count
  end
end
