json.extract! hospital, :id, :name, :address, :phone, :street, :created_at, :updated_at
json.url hospital_url(hospital, format: :json)
