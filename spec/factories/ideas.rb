FactoryGirl.define do
  factory :idea do
    # association :user, factory: :user
    sequence(:title) {|n| "Title_#{n}" }
    description Faker::Lorem.paragraph
  end
end