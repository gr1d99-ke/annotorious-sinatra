# frozen_string_literal: true

require_relative '../uploaders/image_uploader'

class Photo < ActiveRecord::Base
  include ImageUploader::Attachment(:image)

  validates :image, presence: true
end
