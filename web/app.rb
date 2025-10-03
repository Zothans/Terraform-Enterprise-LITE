require "sinatra"
require "sidekiq"
require "sidekiq/api"
require_relative "../workers/terraform_worker"

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

get "/" do
  <<-HTML
    <h1>Lite TFE Demo</h1>
    <form action="/create_bucket" method="post">
      <input type="text" name="bucket_name" placeholder="Bucket Name" required>
      <button type="submit">Create S3 Bucket</button>
    </form>
  HTML
end

post "/create_bucket" do
  bucket = params["bucket_name"]
  job_id = TerraformWorker.perform_async(bucket)
  "Enqueued job #{job_id} to create bucket #{bucket}"
end
