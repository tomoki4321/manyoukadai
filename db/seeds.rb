User.create!(name: "adminuser",
  email: "admin@gmail.com",
  password: "000000",
  admin: true
)

10.times{|n|
  User.create!(
  name: "users"+n.to_s,
  email: "users@"+n.to_s+".com",
  password: "user"+(n.to_s)*4,
  admin: false
  )
}
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

start_day = Date.new(2020,1,1)
last_day = Date.new(2022,12,31)
users = User.all

users = users.map{|user|user.id}

100.times{|n|
  Task.create!(
    task_name: 'タスク名だよ'+n.to_s,
    task_detail: 'タスク内容'+n.to_s,
    expiry_date: rand(start_day..last_day),
    status: rand(1..3),
    priority: rand(1..3),
    user_id: users.sample
  )
}

tasks = Task.all
tasks = tasks.map{|task| task.id}

100.times{|n|
  Labelling.create(
    label_id: rand(1..10),
    task_id: tasks.sample
  )
}