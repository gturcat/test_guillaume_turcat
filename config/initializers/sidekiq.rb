url = ENV["REDISCLOUD_URL"]

# config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
  config.redis = { url: url }
  schedule_file = "config/schedule.yml"
    if File.exist?(schedule_file)
      Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
    end
end

Sidekiq.configure_client do |config|
  config.redis = { url: url }
end

if Rails.env.test?
  require 'sidekiq/testing'
  Sidekiq::Testing.inline!
end
