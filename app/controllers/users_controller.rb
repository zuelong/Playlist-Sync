class UsersController < ApplicationController

  def spotify

    if session[:spotify_token] == nil
      session[:spotify_token] = request.env['omniauth.auth']
    end

    @spotify_user = RSpotify::User.new(session[:spotify_token])
  end

  def youtube

    if session[:youtube_token] == nil
      session[:youtube_token] = request.env['omniauth.auth']['credentials']['token']
    end

    @youtube_user = Yt::Account.new(access_token: session[:youtube_token])
    @spotify_user = RSpotify::User.new(session[:spotify_token])

    @youtube_user.playlists.each do |youtube_playlist|
      spotify_playlist = @spotify_user.create_playlist!(youtube_playlist.title)
      youtube_playlist.playlist_items.each do |track|
        /(?<track_name>^[^\(]*)/ =~ track.title.split(/\sft|\sFt|\sfeat|\sFeat/).first
        spotify_track = RSpotify::Track.search(track_name, limit: 1, market: 'US')
        puts "Search: #{track_name} Result: #{spotify_track.first.name}"
        spotify_playlist.add_tracks!(spotify_track)
      end
    end


  end
end
