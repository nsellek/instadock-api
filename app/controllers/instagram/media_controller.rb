class Instagram::MediaController <ApplicationController
  before_action :get_user

  def show
    media_id = params[:id]

    media = INSTAGRAM.find_media(token, media_id)
    media = {
        media: media['data']
    }

    render json: media, status: 200
  end
end