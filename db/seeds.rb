20.times do |n|
  name = Faker::Name.name
  email = "email_#{n+1}@email.com"
  password = "123456"
  User.create!(name: name,
  email: email,
  password: password,
  password_confirmation: password)
end

User.create!(name: "Pham Qui Duong",
  email: "phamquiduong@outlook.com",
  password: "123456",
  password_confirmation: "123456",
  admin: true)
