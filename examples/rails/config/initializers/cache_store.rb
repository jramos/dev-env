# use Redis for Rails caching

Rails.application.config.cache_store = :redis_store, ENV['REDIS_URL'] + '/cache'