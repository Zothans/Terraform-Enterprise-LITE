Lite Terraform Enterprise (Demo)

This is a lightweight proof-of-concept simulating Terraform Enterprise’s workflow using Sinatra (Ruby web app), Redis, and Sidekiq for background jobs.

It provides a minimal UI with a button to create an S3 bucket. Clicking the button enqueues a job into Redis, processed by Sidekiq, which runs the Terraform CLI to provision the bucket in AWS.

You can also monitor the queued jobs using RedisInsight.

Project Structure

.
├── docker-compose.yml
├── README.txt
├── terraform
│   └── main.tf
├── web
│   ├── app.rb
│   ├── Gemfile
│   ├── Gemfile.lock (will be created)
│   └── Dockerfile (NEW)
└── workers
    └── terraform_worker.rb

🛠️ Requirements
	•	AWS credentials available (via ~/.aws/credentials or env vars AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY).
	•	Docker & Docker Compose installed.
	•	Optional: RedisInsight to visualize jobs in Redis.

🎯 What You'll Get:
Web UI at http://localhost:4567 with a form to create S3 buckets

Jobs queued in Redis

Sidekiq processing jobs and running Terraform

RedisInsight at http://localhost:8001 to monitor Redis


--------------------------
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
git clone https://github.com/zothsn/Terraform-Enterprise-LITE.git
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
