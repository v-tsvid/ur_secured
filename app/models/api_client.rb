class ApiClient < ActiveRecord::Base
  validates :access_token, uniqueness: true
  validates :safe_count, :unsafe_count, numericality: { greater_than: -1 }

  validate :expires_at_cannot_be_in_the_past

  before_save :generate_token
  before_save :token_expires_at
  
  before_validation :counts_to_default
  
  private
    def token_expires_at
      self.expires_at = DateTime.now.next_month
    end

    def generate_token
      # return false unless self.expires_at && self.expires_at <= DateTime.now
      
      self.access_token = loop do
        token = SecureRandom.hex
        break token unless self.class.exists?(access_token: token)
      end
    end

    def counts_to_default
      self.safe_count   ||= 0
      self.unsafe_count ||= 0
    end
    
    def expires_at_cannot_be_in_the_past
      if expires_at && expires_at < DateTime.now
        errors.add(:expires_at, "can't be in the past")
      end
    end
end
