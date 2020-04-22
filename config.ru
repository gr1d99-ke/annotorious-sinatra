require './config/environment.rb'
require './application'

use Rack::Cors do
  allow do
    origins '*'
    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :options, :patch]
  end
end

run Application::Api
