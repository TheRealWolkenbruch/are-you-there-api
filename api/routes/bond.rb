# frozen_string_literal: true

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
end
