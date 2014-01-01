require 'faye/websocket'
require 'thread'

class Backend
  KEEPALIVE_TIME = 15

  MUTEX = Mutex.new

  def initialize(app)

    TweetStream.configure do |config|
      config.consumer_key       = '0oajkeNqoHg4bYYH551A'
      config.consumer_secret    = 'uRgXirGUw5QhjtqF0tRgfLaw0mwUGseDGGe6RmvS0o'
      config.oauth_token        = '2268843889-ZHaziojytEyLUMkmqGe4I4fu7VD5pB2WiGnO2QH'
      config.oauth_token_secret = 'HdNktihKIPgYrnneNTKRvTobBxwExygM4ytPEufyuuaRf'
      config.auth_method        = :oauth
    end

    @app = app
    @clients = []

    Thread.new do
      TweetStream::Client.new.on_inited do
      end.on_enhance_your_calm do
        puts "shit i hit the fucking rate limit"
      end.on_status_withheld do
        puts "shit status withheld"
      end.on_error do |message|
        puts message
      end.follow(304067888) do |status|
        puts "I GOT A STATUS"
        status = "#{status.text} - @#{status.user.screen_name}"
        MUTEX.synchronize {
          @clients.each {|client| client.send(JSON.dump status)}
        }
      end
    end
  end

  def call(env)
    if Faye::WebSocket.websocket?(env)
      ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME})

      ws.on :open do |event|
        p [:open, ws.object_id]
        MUTEX.synchronize {@clients << ws}
        # test loop for jquery don't delete
        # loop do
        #   @clients.each {|client| client.send(JSON.dump "hello this is a message")}
        #   sleep(30)
        # end
      end

      ws.on :close do |event|
        p [:close, ws.object_id, event.code, event.reason]
        MUTEX.synchronize {@clients.delete(ws)}
        ws = nil
      end

      ws.rack_response
    else
      @app.call(env)
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


        # 304067888 ashley
        # 2265270307 test