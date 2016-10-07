p "SEEDING ROLES"
Role.create([
    { name: 'System Administrator', code: 'SA', superadmin: true, description: 'Can manage the complete system.'},
    { name: 'Default User', code: 'DU', default_user: true, description: 'Can manage system without any administrative privileges.'},
    { name: 'Custom User', code: 'CU', custom: true, description: 'Can have different permissions'}
  ])

p "SEEDING USERS"
User.create([
    { first_name: 'System', last_name: 'Administrator', email: 'user1@example.com', username: 'superadmin', password: 'Password1', password_confirmation: 'Password1', active: true, role_id: 1, confirmed_at: Time.current, avatar: Faker::Avatar.image},
    { first_name: 'Default', last_name: 'User', email: 'user2@example.com', username: 'default.user', password: 'Password1', password_confirmation: 'Password1', active: true, role_id: 2, confirmed_at: Time.current, avatar: Faker::Avatar.image},
    { first_name: 'Custom', last_name: 'User', email: 'user3@example.com', username: 'custom.user', password: 'Password1', password_confirmation: 'Password1', active: true, role_id: 3, confirmed_at: Time.current, avatar: Faker::Avatar.image}
  ])

for x in 1..50
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.safe_email, username: Faker::Internet.user_name, password: 'Password1', password_confirmation: 'Password1', active: true, role_id: rand(1..3), confirmed_at: Time.current, avatar: Faker::Avatar.image("my-own-slug"))
end


p "SEEDING USERS CONTACTS"
for x in 1..1000
  UserContact.create(user_id: rand(1..User.count), name: Faker::Name.name, email: Faker::Internet.safe_email, phone: Faker::PhoneNumber.cell_phone, address: Faker::Address.street_address) 
end