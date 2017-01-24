class Api::V1::AnalysesController < BaseApiController
  respond_to :json
  
  def show
    @analysis = Analysis.find_by(uid: params['id'])    
    render json_to_render_on_show
  end

  def create
    @analysis = Api::V1::AnalysisStartingService.new(
      current_client, params['html'], params['javascripts'], params['url']).call

    render save_analyze_hash(params['url'])
  end

  private

    def json_to_render_on_show
      if @analysis
        Api::V1::ResultUpdatingService.new(@analysis).call
        { json: { result: @analysis.result }, status: 200 }
      else
        { json: { errors: 'Not found'}, status: 404 }
      end
    end

    def save_analyze_hash(url)
      if @analysis.id
        Url.find_by(url: url).api_clients << current_client
        { json: { analysis: @analysis.uid }, status: 200 }
      else
        { json: { errors: @analysis.errors }, status: 422 }
      end
    end
end