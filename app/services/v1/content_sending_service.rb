class V1:ContentSendingService
  def call(content, javascript)
    send_content(content)
    send_javascript(javascript)
  end

  private

    def send_content(content)
    end

    def send_javascript(javascript)
    end
end