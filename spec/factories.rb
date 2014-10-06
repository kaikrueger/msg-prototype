FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password 'foobar'
    password_confirmation 'foobar'

    factory :admin do
      admin true
    end
  end

  factory :device do
    sequence(:uuid) { |n| "0000#{n}" }
    sequence(:name) { |n| "Device#{n}" }
    device_type_id 1
    user
  end

  factory :sensor do
    sequence(:uuid) { |n| "0000#{n}" }
    sequence(:name) { |n| "Sensor#{n}" }
    sensor_type_id 1
    device
  end
end
