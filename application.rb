# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/json'

require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :rack_file

module Application
  class Api < Sinatra::Base
  end
end

Dir[File.dirname(__FILE__) + '/api/**'].sort.each do |route|
  require route
end
