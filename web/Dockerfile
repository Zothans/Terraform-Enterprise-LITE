FROM ruby:3.2

# Install Terraform
RUN apt-get update && apt-get install -y wget unzip
RUN wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip
RUN unzip terraform_1.5.0_linux_amd64.zip && mv terraform /usr/local/bin/

WORKDIR /app

# Copy Gemfile first for better caching
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Create workers directory
RUN mkdir -p workers

# Default command
CMD ["ruby", "app.rb", "-o", "0.0.0.0"]
