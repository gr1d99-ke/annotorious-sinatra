# frozen_string_literal: true

module Application
  class Api < Sinatra::Base
    post '/attach' do
      image_data = JSON.parse(request.body.read)
      @photo = Photo.new(image: image_data)
      if @photo.valid?
        @photo.save!
        json @photo
      else
        json errors: @photo.errors
      end
    end
  end
end
