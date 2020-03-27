# frozen_string_literal: true

module Application
  class Api < Sinatra::Base
    get '/' do
      json images: []
    end
  end
end
