Lite Terraform Enterprise (Demo)

This is a lightweight proof-of-concept simulating Terraform Enterprise’s workflow using Sinatra (Ruby web app), Redis, and Sidekiq for background jobs.

It provides a minimal UI with a button to create an S3 bucket. Clicking the button enqueues a job into Redis, processed by Sidekiq, which runs the Terraform CLI to provision the bucket in AWS.

You can also monitor the queued jobs using RedisInsight.

Project Structure
.
├── web/                     # Sinatra app + Sidekiq workers
│   ├── Gemfile              # Ruby gem dependencies
│   ├── Gemfile.lock         # Locked versions (reproducibility)
│   ├── app.rb               # Sinatra web UI
│   ├── worker.rb            # Sidekiq job definition
│   └── views/
│       └── index.erb        # UI template with "Create S3 Bucket" button
├── terraform/               # Terraform config to create S3 bucket
│   └── main.tf
├── docker-compose.yml       # Services (web, redis, sidekiq, redisinsight)
└── README.md


🛠️ Requirements
	•	AWS credentials available (via ~/.aws/credentials or env vars AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY).
	•	Docker & Docker Compose installed.
	•	Optional: RedisInsight to visualize jobs in Redis.


 Quick Start


Bring everything up:
docker-compose up --build

Access the Web UI:
	•	Sinatra app → http://localhost:4567
	•	RedisInsight → http://localhost:8001
	4.	Try it out:
	•	Click “Create S3 Bucket” in the UI.
	•	This enqueues a job in Redis.
	•	Sidekiq picks it up and runs Terraform to create the bucket.
	•	Logs are visible in the Sidekiq container output.

1. Clone the repo:
git clone https://github.com/your-username/lite-tfe-demo.git
cd lite-tfe-demo

2. Bring everything up:
docker-compose up --build

3. Access the Web UI:
	•	Sinatra app → http://localhost:4567
	•	RedisInsight → http://localhost:8001

4.	Try it out:
	•	Click “Create S3 Bucket” in the UI.
	•	This enqueues a job in Redis.
	•	Sidekiq picks it up and runs Terraform to create the bucket.
	•	Logs are visible in the Sidekiq container output.

5. 📊 Monitoring Jobs
	•	Open RedisInsight at http://localhost:8001.
	•	Connect to Redis at redis:6379.
	•	You’ll see queued jobs and Sidekiq activity.

6. ⚙️ Terraform Notes
	•	terraform/main.tf provisions a simple S3 bucket.
	•	The bucket name is auto-generated using a UUID to avoid collisions.
	•	You can customize the Terraform config as needed.


Cleanup

To destroy resources:
cd terraform
terraform destroy -auto-approve


Stop containers:
docker-compose down

 Disclaimer

This project is for educational/demo purposes only.
It’s a simplified simulation of Terraform Enterprise, not production-ready.
