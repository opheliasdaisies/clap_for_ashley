require 'bundler'
Bundler.require
require './lib/backend'

module Ashley
  class Applause < Sinatra::Application
    get '/' do
      erb :index
    end
  end
end