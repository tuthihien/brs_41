require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you"ve limited to :test, :development, or :production.
module Brs41
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    Bundler.require(*Rails.groups)
    Config::Integration::Rails::Railtie.preload
    config.time_zone = Settings.time_zone
  end
end
