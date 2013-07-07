require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require *Rails.groups(:assets => %w(development test))
end

module KanbanRoots
  class Application < Rails::Application
    # Enable the assets pipeline
    config.assets.enabled = true

    # Version of your assets, change if you want to expire all your assets
    config.assets.version = '1.0'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    #config.quiet_assets = false

    config.assets.initialize_on_precompile = false
    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Configure generators values.
    config.generators do |g|
      g.stylesheets false
      g.template_engine :slim
      g.test_framework :rspec,
                       :view_specs => false,
                       :fixture_replacement => :factory_girl
    end

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    #config.time_zone = 'Europe/France'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :fr

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    #CarrierWave.configure do |config|
    #  config.fog_credentials = {
    #      :provider               => 'AWS',                        # required
    #      :aws_access_key_id      => '',                        # required
    #      :aws_secret_access_key  => '',                        # required
    #      :region                 => ''                  # optional, defaults to 'us-east-1'
    #  }
    #  #:host                   => 's3.example.com',             # optional, defaults to nil
    #  #:endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
    #  config.fog_directory  = 'kanban4ninjas'                     # required
    #  config.fog_public     = false                                   # optional, defaults to true
    #  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
    #end

  end
end

