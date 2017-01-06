FactoryGirl.define do
  factory :metric do
    browser { ['Firefox', 'Opera', 'Chrome', 'Safari', 'IE'].sample }
    
    api_client
  end
end
