require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module JourneyMe
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_record.schema_migrations_table_name = 'public.schema_migrations'

    config.action_mailer.delivery_method = :postmark
    config.action_mailer.postmark_settings = { :api_token => "POSTMARK-SERVER-API-TOKEN-HERE" }
  end
end
