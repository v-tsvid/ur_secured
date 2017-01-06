class Url < ActiveRecord::Base
  has_and_belongs_to_many :api_clients
end
