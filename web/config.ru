require './app'
require 'sidekiq/web'
require 'rack/session'

# Generate a secure session secret if not in environment
session_secret = ENV['SESSION_SECRET'] || 'development-secret-key-change-in-production'

# Add session middleware for CSRF protection
use Rack::Session::Cookie, 
    secret: session_secret,
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
