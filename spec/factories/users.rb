FactoryBot.define do
  factory :admin_user, class: User do
    name { "adminuser1" }
    email { "admin@gmail.com" }
    password { "000000" }
    password_confirmation { "000000" }
    admin {true}
  end

  factory :user do
    name { "nomaluser" }
    email { "nomal@gmail.com" }
    password { "111111" }
    password_confirmation { "111111" }
    admin {false}
  end
end
