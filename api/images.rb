# frozen_string_literal: true

module Application
  class Api < Sinatra::Base
    attach_image = lambda do
      @photo = Photo.new(image: params[:file])
      if @photo.valid?
        @photo.save!
        json @photo
      else
        json errors: @photo.errors
      end
    end

    post '/attach', {}, &attach_image
  end
end
