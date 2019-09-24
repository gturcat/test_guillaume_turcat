$redis = Redis.new

url = ENV["REDISCLOUD_URL"]

if url
  # Sidekiq.configure_server do |config|
  #   config.redis = { url: url }
  # end

  # Sidekiq.configure_client do |config|
  #   config.redis = { url: url }
  # end
  $redis = Redis.new(:url => url)

  # schedule_file = "config/schedule.yml"
  #   if File.exist?(schedule_file)
  #     Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  #   end
end

# if Rails.env.test?
#   require 'sidekiq/testing'
#   Sidekiq::Testing.inline!
# end
