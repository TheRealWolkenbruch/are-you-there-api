# frozen_string_literal: true

class App < Roda
  WHITELIST_PARAMS = %w(human_readable_name contactdata email password)

  route('wards') do |r|
    r.get do
      account_id = rodauth.jwt_session_hash[:account_id]
      DB[:wards].where(f_guardian_id: account_id).map { |v| v.reject { |k, _v| k == :password } }.to_json
    end

    r.on 'create' do
      r.post do
        unless params_valid?(r.params)
          response.status = 400
          response.write 'Missing parameters or too many'
          r.halt
        end

        unless params_set?(r.params)
          response.status = 400
          response.write 'Not all params have a value'
          r.halt
        end
        account_id = rodauth.jwt_session_hash[:account_id]

        ward_id = DB[:wards]
          .insert(f_guardian_id: account_id,
                  human_readable_name: r.params['human_readable_name'],
                  contactdata: r.params['contactdata'],
                  email: r.params['email'],
                  # MVP solution, guardian set password for ward.
                  password: BCrypt::Password.create(r.params['password']))

        { ward_id: ward_id }.to_json
      end
    end
  end

  def params_valid?(params)
    params.keys.sort == WHITELIST_PARAMS.sort
  end

  def params_set?(params)
    params.values.compact.size == WHITELIST_PARAMS.count
  end
end
