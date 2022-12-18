1.times do |n|
  name =  "test_user"
  email = "1111@gmail.com"
  password = "000000"
  admin = "true"
  User.create!(name: name,
              email: email,
              password: password,
              admin: admin
  )
end