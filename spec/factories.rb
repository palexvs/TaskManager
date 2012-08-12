FactoryGirl.define do
  factory :user_invalid_password, class: User do
    email    "test@test.com"
    password "test"
  end

  factory :user do
    email    "test@test.com"
    password "testtest"
  end  

  factory :project do
    name  "First Project"
    user
  end
end