json.extract! user, :id, :first_name, :last_name, :last_name, :username, :email, :avatar, :active, :created_at, :updated_at
json.url user_url(user, format: :json)