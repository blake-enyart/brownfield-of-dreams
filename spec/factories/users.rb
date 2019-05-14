FactoryBot.define do
  factory :user do
    email  { Faker::Internet.email }
    first_name { Faker::Dog.name }
    last_name { Faker::Artist.name }
    password { 'password' }
    role { :default }
    github_uid { 1111111 }
  end

  factory :admin, parent: :user do
    role { :admin }
    password { 'password' }
  end
end
