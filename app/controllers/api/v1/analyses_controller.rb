class Api::V1::AnalysesController < BaseApiController
  respond_to :json
  
  def show
    @analysis = Analysis.find_by(uid: params['id'])    
    render json_to_render_on_show and return
  end

  def create
    @answer_checker = Api::V1::ContentCheckingService.new(
      params['html'], params['javascripts'])
    render save_analyze_hash(params['url'])
  end

  private

    def json_to_render_on_show
      if @analysis
        @analysis.contents.each do |content|
          if content.safe? != true
            { json: { answer: content.safe? }, status: 200 }
          end
        end
        { json: { answer: true }, status: 200 }
      else
        { json: { answer: nil }, status: 404 }
      end
    end

    def save_analyze_hash(url)
      answer = @answer_checker.call
      url = Url.where(url: url).first_or_create
      if url.update(url: url, safe?: answer)
        url.api_clients << current_client
        { json: { answer: answer }, status: 200 }
      else
        { json: { errors: url }, status: 422 }
      end
    end
end