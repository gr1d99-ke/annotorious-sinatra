require './config/environment.rb'
require './application'
map '/presign' do
  run Shrine.presign_endpoint(:cache)
end

run Application::Api
