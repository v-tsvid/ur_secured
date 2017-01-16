require 'faker'
require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)

if Rails.env == 'development' || Rails.env == 'production' 
  FactoryGirl.create_list :api_client_with_metrics_and_urls, 10
  FactoryGirl.create_list :content, rand(1000..10000)
end