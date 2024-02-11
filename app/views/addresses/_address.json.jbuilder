json.extract! address, :id, :number, :street, :suburb, :city, :state, :postcode, :country, :created_at, :updated_at
json.url address_url(address, format: :json)
