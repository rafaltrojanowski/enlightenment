Sidekiq.configure_server do |config|
  if Rails.env.development?
    config.redis = { url: 'http://localhost:6379' }
  else
    config.redis = { url: ENV["REDIS_URL"], namespace: 'gete' }
  end
end

Sidekiq.configure_client do |config|
  if Rails.env.development?
    config.redis = { url: 'http://localhost:6379' }
  else
    config.redis = { url: ENV["REDIS_URL"], namespace: 'gete' }
  end
end