class Content < ActiveRecord::Base
  validates :code_md5, uniqueness: { scope: [:original_length, :type] }
  
  scope :by_md5_and_length, -> (code_md5, original_length) {
    where(code_md5: code_md5, original_length: original_length)
  }

  class << self
    
    def get_answer_or_persist(code_md5, original_length)
      by_md5_and_length(code_md5, original_length).first_or_create.safe?
    end
  end
end
