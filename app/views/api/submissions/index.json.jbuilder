json.array!(@submissions) do |submission|
  json.extract! submission, :id, :content, :valoracio, :titol, :url, :user_id, :created_at, :updated_at
end
