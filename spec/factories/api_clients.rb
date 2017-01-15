FactoryGirl.define do
  factory :api_client do
    access_token { SecureRandom.hex }
    expires_at   { DateTime.now.next_year }
    safe_count   { rand(0..9999) }
    unsafe_count { rand(0..9999) }

    factory :api_client_with_metrics_and_urls do
      ignore do
        metric_count { rand(1..3) }
        ary          { array_of(ApiClient) }
      end
      
      after(:create) do |client, ev|
        create_list(:metric, ev.metric_count, api_client: client)
        create_list(:url, rand(1..100), api_clients: ev.ary.push(client).uniq)
      end
    end
  end
end
