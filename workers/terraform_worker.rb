require "sidekiq"
require "securerandom"

class TerraformWorker
  include Sidekiq::Worker

  def perform(bucket_name)
    job_id = SecureRandom.uuid
    puts "[Job #{job_id}] Creating bucket: #{bucket_name}"

    # Use correct path inside container
    tfvars_path = "/app/terraform/vars.tfvars"
    File.write(tfvars_path, "bucket_name = \"#{bucket_name}\"\n")

    Dir.chdir("/app/terraform") do
      puts "[Job #{job_id}] Initializing Terraform..."
      unless system("terraform init -input=false")
        puts "[Job #{job_id}] ERROR: Terraform init failed"
        return
      end
      
      puts "[Job #{job_id}] Applying Terraform configuration..."
      unless system("terraform apply -auto-approve -var-file=vars.tfvars")
        puts "[Job #{job_id}] ERROR: Terraform apply failed"
        return
      end
    end

    puts "[Job #{job_id}] Successfully created bucket: #{bucket_name}"
  end
end
