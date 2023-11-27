Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:7963/1' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:7963/1' }
end
