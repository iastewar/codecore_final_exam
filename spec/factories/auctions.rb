FactoryGirl.define do
  factory :auction do
    association :user, factory: :user
    title "MyString"
details "MyText"
ends_on "2015-12-11 10:15:06"
reserve_price 1.5
current_price 1.5
  end

end
