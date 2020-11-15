FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'text@example.com' }
    password { 'password' }
  end
end