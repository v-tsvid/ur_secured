FactoryGirl.define do
  factory :api_client do
    access_token { SecureRandom.hex }
    expires_at   { DateTime.now.next_year }
    safe_count   { rand(0..9999) }
    unsafe_count { rand(0..9999) }
  end
end
