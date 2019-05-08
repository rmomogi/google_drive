FactoryBot.define do
  factory :document do
    title { 'Title' }
    content { Faker::Lorem.paragraph }
    user { build(:user) }
  end
end
