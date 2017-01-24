class Api::V1::AnalyzingService
  def initialize(code)
    @code = code
  end

  def call
    analyze
  end

  private

    def analyze
      sleep 5
      return @code.length.even? ? true : false
    end
end