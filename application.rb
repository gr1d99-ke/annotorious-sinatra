# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/json'

module Application
  class Api < Sinatra::Base
  end
end

Dir[File.dirname(__FILE__) + '/api/**'].sort.each do |route|
  require route
end
