require "sinatra"
require "sidekiq"
require "sidekiq/api"
require "sidekiq/web"

# Add these lines at the top
set :bind, '0.0.0.0'
set :port, 4567

# Load the worker file
require_relative "./workers/terraform_worker"

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

# Mount Sidekiq web interface
map '/sidekiq' do
  run Sidekiq::Web
end

get "/" do
  <<-HTML
    <!DOCTYPE html>
    <html>
    <head>
        <title>Lite TFE Demo</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 40px; }
            form { margin: 20px 0; }
            input, button { padding: 10px; margin: 5px; }
            .jobs { margin-top: 30px; }
        </style>
    </head>
    <body>
        <h1>Lite Terraform Enterprise Demo</h1>
        <form action="/create_bucket" method="post">
            <input type="text" name="bucket_name" placeholder="Enter S3 bucket name" required>
            <button type="submit">Create S3 Bucket</button>
        </form>
        
        <div class="jobs">
            <h3>Background Jobs</h3>
            <p><a href="/sidekiq">View Sidekiq Dashboard</a></p>
        </div>
    </body>
    </html>
  HTML
end

post "/create_bucket" do
  bucket_name = params["bucket_name"]
  job_id = TerraformWorker.perform_async(bucket_name)
  "Enqueued job #{job_id} to create bucket: #{bucket_name}<br><a href='/'>Back</a>"
end
