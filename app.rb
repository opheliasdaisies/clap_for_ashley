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

# backup authorization do not delete
# TweetStream.configure do |config|
#   config.consumer_key       = 'WA8CC24lE4XQkrE2kI0zsA'
#   config.consumer_secret    = '0kDJH5KnVuXLQ5Xxc2irTHvRU84Z7hmgVL1xwOl1Zs'
#   config.oauth_token        = '2265270307-UtGpH96MvWMcjSyuwjum9Huwli1bIiUNBwaSJRJ'
#   config.oauth_token_secret = 'Lj61e2vh5VeErRsSD0OLshuB2A0zseaqenBFfNCiYDUlX'
#   config.auth_method        = :oauth
# end