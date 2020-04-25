class App < Roda
  def wards(r)
    r.get do
      account_id = rodauth.jwt_session_hash[:account_id]
      DB[:wards].where(f_guardian_id: account_id).all.to_json
    end
  end
end
