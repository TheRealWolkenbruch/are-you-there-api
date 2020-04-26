# frozen_string_literal: true

require_relative '../../models/wards'
class App < Roda
  route('bonds') do |r|
    # route[List_bonds]: /api/bonds
    r.get do
      account_id = rodauth.jwt_session_hash[:account_id]
      DB[:bonds].join(:schedules, id: :f_schedule_id).join(:wards, id: :f_ward_id).where(f_guardian_id: account_id).map do |v|
        {
          'message' => v[:feedback_message],
          'email' => v[:email],
          'valid_to' => v[:valid_to]
        }
      end .to_json
    end
  end
end
