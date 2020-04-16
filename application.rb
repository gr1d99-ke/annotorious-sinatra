# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/json'

require "content_disposition"
require "shrine"
require "shrine/storage/s3"

s3_options = {
  access_key_id: ENV['access_key_id'],
  secret_access_key: ENV['secret_access_key'],
  bucket: ENV['bucket'],
  region: ENV['region']
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
  store: Shrine::Storage::S3.new(prefix: 'store', **s3_options)
}

Shrine.plugin :presign_endpoint, presign_options: -> (request) {
  filename = request.params["filename"]
  type     = request.params["type"]

  opts = {
    content_disposition:    ContentDisposition.inline(filename), # set download filename
    content_type:           type,                                # set content type (required if using DigitalOcean Spaces)
    content_length_range:   0..(10*1024*1024),                   # limit upload size to 10 MB
  }
  p opts
  opts
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :rack_file
Shrine.plugin :presign_endpoint
Shrine.plugin :upload_options, store: -> (io, **) { { acl: "private" } }

Dir[File.dirname(__FILE__) + '/models/**'].sort.each do |model|
  require model
end

Dir[File.dirname(__FILE__) + '/models/**'].sort.each do |model|
  require model
end

module Application
  class Api < Sinatra::Base
  end
end

Dir[File.dirname(__FILE__) + '/api/**'].sort.each do |route|
  require route
end
