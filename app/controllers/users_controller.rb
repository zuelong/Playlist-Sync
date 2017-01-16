class UsersController < ApplicationController
  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
  end

  def youtube
    unless @youtube_user.is_a? Yt::Account
      @youtube_user = Yt::Account.new(access_token: request.env['omniauth.auth']['credentials']['token'])
    end
  end
end
