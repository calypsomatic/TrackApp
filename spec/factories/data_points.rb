# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :data_point do
    moment_id 1
    amount 1
    date "2014-01-06 17:42:10"
  end
end
