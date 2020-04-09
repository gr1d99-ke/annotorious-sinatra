class ImageUploader < Shrine
  plugin :validation_helpers

  Attacher.validate do
    validate_max_size 10 * 1024 * 1024 # ensure image size is less than 10MB
    validate_mime_type %w[image/jpeg image/png], message: 'invalid image'
  end
end
