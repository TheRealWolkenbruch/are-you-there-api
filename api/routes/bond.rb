# frozen_string_literal: true

class App < Roda
  route('bond') do |r|
    r.get String do |url_stub_id|
      bond = Bond.where(url_stub_id: url_stub_id).first
      if bond.nil?
        response.status = 404
        response.write("<h1>Sorry, I don't know what you mean </h1>")
        r.halt
      end
      bond.update(seen_at: Time.now)

      r.redirect "https://app.areyouthere.de/#{url_stub_id}"
    end

    r.post 'update' do
      { success: 'Endpoint reached' }.to_json
    end
  end
end
