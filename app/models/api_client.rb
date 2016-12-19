class ApiClient < ActiveRecord::Base
  before_create :generate_token
  before_create :token_expires_at
  
  private
    def token_expires_at
      self.expires_at = DateTime.now.next_month
    end

    def generate_token
      begin
        self.access_token = SecureRandom.hex
      end while self.class.exists?(access_token: self.access_token)
    end
end
