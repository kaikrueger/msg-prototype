FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :sensor do
    sequence(:uuid) { |n| "0000#{n}" }
    sequence(:name) { |n| "Sensor#{n}" }
  end
end
