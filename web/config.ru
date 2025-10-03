require './app'
require 'sidekiq/web'
require 'rack/session'

# Add session middleware for CSRF protection
use Rack::Session::Cookie, 
    secret: ENV['SESSION_SECRET'] || 'your-secret-key-here-change-in-production',
    same_site: true, 
    max_age: 86400

map '/sidekiq' do
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'admin' && password == 'password'
  end
  run Sidekiq::Web
end

map '/' do
  run Sinatra::Application
end
