json.extract! user_contact, :id, :user_id, :name, :email, :phone, :address, :created_at, :updated_at
json.url user_contact_url(user_contact, format: :json)