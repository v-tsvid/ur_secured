FactoryGirl.define do
  factory :content do
    type  { ['Html', 'Javascript'].sample }
    code_md5  { Faker::Crypto.md5 }
    original_length { rand(10..300000) }
    safe? { [true, false].sample }
  end
end
