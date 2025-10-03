# Lite Terraform Enterprise (Demo)

A lightweight proof-of-concept simulating Terraform Enterprise's workflow using Sinatra (Ruby web app), Redis, and Sidekiq for background jobs.

This demo provides a minimal UI where you can create S3 buckets via Terraform runs managed through a job queue system.

## 🚀 Overview

- **Web Interface**: Simple Sinatra app with a form to create S3 buckets
- **Job Queue**: Redis-backed queue system using Sidekiq
- **Terraform Execution**: Background workers process jobs and run Terraform CLI
- **Monitoring**: Real-time job monitoring via RedisInsight

## 📁 Project Structure
.
├── docker-compose.yml # Service definitions
├── terraform/
│ └── main.tf # Terraform configuration for S3 bucket
├── web/
│ ├── app.rb # Sinatra web application
│ ├── Gemfile # Ruby dependencies
│ └── Dockerfile # Container configuration
└── workers/
└── terraform_worker.rb # Sidekiq worker for Terraform execution

text

## 🛠️ Prerequisites

- **Docker & Docker Compose**
- **AWS Credentials** (via environment variables or AWS CLI configuration)
- **RedisInsight** (optional, for monitoring)

## ⚡ Quick Start

### 1. Clone and Setup
```bash
git clone https://github.com/zothans/Terraform-Enterprise-LITE.git
cd Terraform-Enterprise-LITE
2. Configure AWS Credentials
Create a .env file in the project root:

bash
# .env
AWS_ACCESS_KEY_ID=your_access_key_here
AWS_SECRET_ACCESS_KEY=your_secret_key_here
AWS_DEFAULT_REGION=ap-southeast-2
⚠️ Important: Add .env to your .gitignore to avoid committing secrets.

3. Start the Application
bash
docker-compose up --build
4. Access the Services
Web UI: http://localhost:4567

RedisInsight: Connect to localhost:6379 using your local RedisInsight app

🎯 Usage
Open http://localhost:4567 in your browser

Enter a unique S3 bucket name in the form

Click "Create S3 Bucket"

The job will be queued in Redis and processed by Sidekiq

Watch the Docker logs to see Terraform execution in real-time

📊 Monitoring
Using RedisInsight
Open your local RedisInsight application

Add a new connection:

Host: localhost

Port: 6379

Name: Terraform-LITE

Monitor Sidekiq queues and job activity

Viewing Logs
bash
# View all service logs
docker-compose logs

# View specific service logs
docker-compose logs worker
docker-compose logs web
⚙️ Configuration
Environment Variables
The following environment variables are required:

Variable	Description	Default
AWS_ACCESS_KEY_ID	AWS Access Key	-
AWS_SECRET_ACCESS_KEY	AWS Secret Key	-
AWS_DEFAULT_REGION	AWS Region	ap-southeast-2
REDIS_URL	Redis connection URL	redis://redis:6379
Customizing Terraform
Edit terraform/main.tf to modify the AWS resources:

hcl
# terraform/main.tf
resource "aws_s3_bucket" "demo" {
  bucket = var.bucket_name
  # Add additional S3 configurations here
}
🧹 Cleanup
Stop Containers
bash
docker-compose down
Destroy AWS Resources
To destroy all created S3 buckets:

bash
cd terraform
terraform destroy -auto-approve
🔧 Troubleshooting
Common Issues
"Repository not found" error

Ensure the repository URL is correct in git remote

AWS credentials not working

Verify your AWS credentials in the .env file

Check that the AWS_DEFAULT_REGION is set

Terraform initialization fails

Ensure AWS credentials have S3 permissions

Check network connectivity to AWS

Viewing Debug Information
Visit http://localhost:4567/env to check environment variable configuration.

⚠️ Disclaimer
This project is for educational and demonstration purposes only. It is a simplified simulation of Terraform Enterprise and is not production-ready.

Not recommended for production use due to:

No authentication/authorization

Limited error handling

No state management

Basic security considerations

🤝 Contributing
Feel free to submit issues and enhancement requests!

📄 License
This project is licensed under the MIT License.

text

## **Key Improvements Made:**

1. **Better Structure**: Clear sections with emoji headers
2. **Proper Markdown Formatting**: Code blocks, tables, and lists
3. **Step-by-Step Instructions**: Numbered steps for clarity
4. **Troubleshooting Section**: Common issues and solutions
5. **Security Notes**: Clear warnings about production use
6. **Environment Variables Table**: Clear documentation of required variables
7. **Monitoring Instructions**: Detailed RedisInsight setup
8. **Cleanup Instructions**: Separate sections for containers and AWS resources
9. **Professional Tone**: More formal and comprehensive

## **Additional Suggestions:**

1. **Rename to README.md** for better GitHub rendering
2. **Add a LICENSE file** if you want others to use it
3. **Consider adding screenshots** of the web UI
4. **Add a demo GIF** showing the workflow in action

This improved README will make it much easier for others to understand and use your project!

