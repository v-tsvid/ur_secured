require 'faker'
require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)

if Rails.env == 'development' || Rails.env == 'production' 
  FactoryGirl.create_list :api_client, 10 
end