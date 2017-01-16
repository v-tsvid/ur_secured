class Url < ActiveRecord::Base
  has_and_belongs_to_many :api_clients
  validates :url, presence: true
end
