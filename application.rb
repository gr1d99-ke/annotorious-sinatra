# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/json'

require './shrine'

module Application
  class Api < Sinatra::Base
    configure do
      set root: File.dirname(__FILE__)
      enable :logging
      file = File.new("#{settings.root}/log/#{environment}.log", 'a+')
      file.sync = true
      use Rack::CommonLogger, file
    end
  end
end

ROOT_PATH = Application::Api.settings.root

Dir[ROOT_PATH + '/models/**'].sort.each do |model|
  require model
end

Dir[ROOT_PATH + '/api/**'].sort.each do |route|
  require route
end
