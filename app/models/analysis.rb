class Analysis < ActiveRecord::Base
  belongs_to :api_client
  has_and_belongs_to_many :contents
end
