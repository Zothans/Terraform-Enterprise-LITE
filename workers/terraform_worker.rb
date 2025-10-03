require "sidekiq"
require "securerandom"

class TerraformWorker
  include Sidekiq::Worker
  sidekiq_options queue: "terraform"

  def perform(bucket_name)
    job_id = SecureRandom.uuid
    puts "[Job #{job_id}] Creating bucket: #{bucket_name}"

    tfvars_path = "/terraform/vars.tfvars"
    File.write(tfvars_path, "bucket_name = \"#{bucket_name}\"\n")

    Dir.chdir("/terraform") do
      system("terraform init -input=false")
      system("terraform apply -auto-approve -var-file=vars.tfvars")
    end

    puts "[Job #{job_id}] Completed bucket creation: #{bucket_name}"
  end
end
