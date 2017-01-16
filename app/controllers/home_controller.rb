class HomeController < ApplicationController
  def index
    #@yt_auth_url = Yt::Account.new(scopes: ['youtube'], redirect_uri: 'http://lvh.me:3000/auth/youtube/callback').authentication_url
  end
end
