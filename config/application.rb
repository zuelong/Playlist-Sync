require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PlaylistSync
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    RSpotify::authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET'])

    Yt.configure do |config|
      config.client_id = ENV['GOOGLE_CLIENT_ID']
      config.client_secret = ENV['GOOGLE_SECRET']
    end

    Thread.new{
      %x`postgres -D /usr/local/var/postgres`
    }
  end
end
