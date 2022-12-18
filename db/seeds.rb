User.create!(name: "adminuser",
  email: "admin@gmail.com",
  password: "000000",
  admin: true
)

User.create!(name: "user",
email: "user@gmail.com",
password: "111111",
admin: false
)