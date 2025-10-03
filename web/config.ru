require './app'
require 'sidekiq/web'

# Mount Sidekiq web interface
map '/sidekiq' do
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'admin' && password == 'password'
  end
  run Sidekiq::Web
end

# Mount main app
map '/' do
  run Sinatra::Application
end
