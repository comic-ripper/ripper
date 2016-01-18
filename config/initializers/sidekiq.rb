Sidekiq.configure_server do |config|
  config.error_handlers << proc { |ex, ctx_hash| Airbrake.notify(ex, ctx_hash) }
end
