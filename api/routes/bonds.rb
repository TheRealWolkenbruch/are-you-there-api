# frozen_string_literal: true

require_relative '../../models/wards'
class App < Roda
  route('bond') do |r|
    r.on String do |url_stub_id|
      bond = Bond.where(url_stub_id: url_stub_id).first

      if bond.nil?
        response.status = 404
        response.write("<h1>Sorry, I don't know what you mean </h1>")
        r.halt
      end

      r.get do
        bond.update(seen_at: Time.now)
        r.redirect "https://app.areyouthere.de/#{url_stub_id}"
      end

      r.post 'update' do
        bond.update(feedback_message: r.params['feedback_message'])

        { success: 'Feedback was given' }.to_json
      end
    end
  end
  route('bonds', 'auth_api') do |r|
    # route[List_bonds]: /api/bonds
    r.get do
      account_id = rodauth.jwt_session_hash[:account_id]
      DB[:bonds].join(:schedules, id: :f_schedule_id).join(:wards, id: :f_ward_id).where(f_guardian_id: account_id).map do |v|
        {
          'message' => v[:feedback_message],
          'email' => v[:email],
          'valid_to' => v[:valid_to]
        }
      end.to_json
    end
  end
end
