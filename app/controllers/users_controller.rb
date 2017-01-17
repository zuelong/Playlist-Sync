class UsersController < ApplicationController

  def spotify

    if session[:spotify_token] == nil
      session[:spotify_token] = request.env['omniauth.auth']
    end

    @spot = RSpotify::User.new(session[:spotify_token])
  end

  def youtube

    if session[:youtube_token] == nil
      session[:youtube_token] = request.env['omniauth.auth']['credentials']['token']
    end

    @yt = Yt::Account.new(access_token: session[:youtube_token])
  end

  def sync
    @yt = Yt::Account.new(access_token: session[:youtube_token])
    @spot = RSpotify::User.new(session[:spotify_token])

    sync_playlists

    render 'users/spotify'
  end

  private
  def sync_playlists
    @yt.playlists.each do |yt_playlist|
      spot_playlist = @spot.create_playlist!(yt_playlist.title)
      yt_playlist.playlist_items.each do |yt_track|
        /(?<track_name>^[^\(\[]*)/ =~ yt_track.title.split(/\sft|\sFt|\sfeat|\sFeat/).first
        spot_track = RSpotify::Track.search(track_name, limit: 1, market: 'US')
        puts "Search: #{track_name} Result: #{spot_track.first.name}"
        spot_playlist.add_tracks!(spot_track)
      end
    end
  end

end
