Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local = true

  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=172800"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :test

  host = "localhost:3000"
  config.action_mailer.default_url_options = {host: host}

  config.action_mailer.perform_caching = false

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.assets.debug = true

  config.assets.quiet = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
