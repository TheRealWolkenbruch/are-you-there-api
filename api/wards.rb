class App < Roda
  def wards(r)
    r.get do
      DB[:wards].first.to_hash.to_json
    end
  end
end