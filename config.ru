require './config/environment.rb'
require './application'
map '/upload' do
  run Shrine.upload_endpoint(:cache)
end

run Application::Api
