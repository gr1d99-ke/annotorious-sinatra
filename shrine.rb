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

Shrine.plugin :presign_endpoint, presign_options: -> (request) do
  {
    content_length_range: 0..(10*1024*1024),                  # limit filesize to 10MB
  }
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :rack_file
