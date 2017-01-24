class Analysis < ActiveRecord::Base
  validates :uid, uniqueness: true
  
  belongs_to :api_client
  belongs_to :url
  has_and_belongs_to_many :contents

  before_save :generate_uid!

  private 

    def generate_uid!
      self.uid = loop do
        uid = SecureRandom.uuid
        break uid unless self.class.exists?(uid: uid)
      end
    end
end
