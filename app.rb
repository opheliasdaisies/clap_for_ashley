require 'bundler'
Bundler.require
require './lib/backend'

module Ashley
  class Applause < Sinatra::Application

    TweetStream.configure do |config|
      config.consumer_key       = '0oajkeNqoHg4bYYH551A'
      config.consumer_secret    = 'uRgXirGUw5QhjtqF0tRgfLaw0mwUGseDGGe6RmvS0o'
      config.oauth_token        = '2268843889-ZHaziojytEyLUMkmqGe4I4fu7VD5pB2WiGnO2QH'
      config.oauth_token_secret = 'HdNktihKIPgYrnneNTKRvTobBxwExygM4ytPEufyuuaRf'
      config.auth_method        = :oauth
    end

    get '/' do
      erb :index
    end
  end
end

# TweetStream.configure do |config|
#   config.consumer_key       = 'WA8CC24lE4XQkrE2kI0zsA'
#   config.consumer_secret    = '0kDJH5KnVuXLQ5Xxc2irTHvRU84Z7hmgVL1xwOl1Zs'
#   config.oauth_token        = '2265270307-UtGpH96MvWMcjSyuwjum9Huwli1bIiUNBwaSJRJ'
#   config.oauth_token_secret = 'Lj61e2vh5VeErRsSD0OLshuB2A0zseaqenBFfNCiYDUlX'
#   config.auth_method        = :oauth
# end