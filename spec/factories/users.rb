# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }

    # DBカラムが email_address に変更されているためこちらを使う
    email_address { Faker::Internet.email }

    introduction { Faker::Lorem.characters(number: 20) }
    password { 'password' }
    password_confirmation { 'password' }

    after(:build) do |user|
      file_path = Rails.root.join('spec/fixtures/files/profile_image.jpeg')
      user.profile_image.attach(
        io: File.open(file_path),
        filename: 'profile_image.jpeg',
        content_type: 'image/jpeg'
      )
    end
  end
end
