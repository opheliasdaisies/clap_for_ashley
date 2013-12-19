require 'bundler'
Bundler.require

module Ashley
  class Applause < Sinatra::Application

    get '/' do
      "test"
    end

  end
end