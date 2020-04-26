# frozen_string_literal: true

class App < Roda
  route('wards') do |r|
    r.get do
      account_id = rodauth.jwt_session_hash[:account_id]
      DB[:wards].where(f_guardian_id: account_id).map { |v| v.reject { |k, _v| k == :password } }.to_json
    end
  end
end
