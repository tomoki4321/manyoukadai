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
labels = [
  {id: 1, label_name: "日本"},
  {id: 2, label_name: "アメリカ"},
  {id: 3, label_name: "インド"},
  {id: 4, label_name: "ドイツ"},
  {id: 5, label_name: "フランス"},
  {id: 6, label_name: "アルゼンチン"},
  {id: 7, label_name: "イタリア"},
  {id: 8, label_name: "スペイン"},
  {id: 9, label_name: "クロアチア"},
  {id: 10, label_name: "韓国"},
]
labels.each do |label|
  Label.find_or_create_by(label)
end