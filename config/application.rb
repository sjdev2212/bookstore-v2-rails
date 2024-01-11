require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyRailsPostgres
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

 

    config.before_configuration do
      env_file = File.join(Rails.root, '.env')
      if File.exist?(env_file)
        require 'dotenv'
        Dotenv.load(env_file)
      end
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:3000'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete], credentials: true
      end
    end

  end
end
