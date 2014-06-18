# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stop do
    street_on "MyString"
    street_cross "MyString"
    boardings "9.99"
    alightings "9.99"
  end
end
