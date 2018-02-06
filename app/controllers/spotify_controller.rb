class SpotifyController < ApplicationController

  def authorize
    render json: {message: "Visit this url", url: "https://accounts.spotify.com/authorize/?client_id=#{ENV['CLIENT_ID']}&response_type=code&redirect_uri=http://localhost:3000/spotify/callback"}
  end

  def callback
    render json: {code: params[:code], error: params[:errors], state: params[:state]}
  end

  def tokens
    response = Unirest.post("https://accounts.spotify.com/api/token", 
      parameters: {
        grant_type: "authorization_code",
        code: params[:code],
        redirect_uri: "http://localhost:3000/spotify/callback",
        client_id: ENV["CLIENT_ID"],
        client_secret: ENV["SECRET"]
      }
    )
    p response.body
    render json: {
      access_token: response.body["access_token"],
      token_type: response.body["token_type"],
      scope: response.body["scope"],
      expires_in: response.body["expires_in"],
      refresh_token: response.body["refresh_token"]
    }
  end

  def profile
    response = Unirest.get("https://api.spotify.com/v1/me",
      headers: {"Authorization" => "Bearer #{params[:access_token]}"}
    )

    render json: response.body
  end

end
