FactoryGirl.define do
  factory :user do
    sequence(:first_name) { Faker::Name.first_name }
  sequence(:last_name)  { Faker::Name.last_name  }
  # using a sequence with block variable (`n` in this case) gives you a number
  # that increments every time you use the factory. This is useful to ensure
  # that values such as email are unique.
  sequence(:email)      {|n| "#{n}.#{Faker::Internet.email}" }

  # the password in this case will be the same for all the record using 
  # the factory (within a loaded environment)
  password              Faker::Internet.password
  end

end
