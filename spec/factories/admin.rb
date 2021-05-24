FactoryBot.define do
  factory :admin do
    email { 'rspec_admin@test.com' }
    password { 'rspec_admin' }
  end
end