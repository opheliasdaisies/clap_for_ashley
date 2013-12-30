require 'faye/websocket'
require 'thread'

class Backend
  KEEPALIVE_TIME = 15

  def initialize(app)
    @app = app
    @clients = []
    puts "THREADING"
    Thread.new do
      puts "INSIDE THREAD"
      TweetStream::Client.new.on_inited do
        puts "started"
      end.on_enhance_your_calm do
        invoke_callback(callbacks['enhance_your_calm'])
        puts "shit blocked"
      end.on_status_withheld do
        puts "shit status withheld"
      end.on_error do |message|
        puts message
      end.follow(304067888) do |status|
        status = "#{status.text}"
        @clients.each {|client| client.send(JSON.dump status)}
        puts "I got a status!!!"
      end
      puts "i should not get hereeeee"
    end
  end

  def call(env)
    #inspects env to check whether the incoming request is a WebSockets request
    if Faye::WebSocket.websocket?(env)
      ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME})

      #maybe open connection here
      ws.on :open do |event|
        p [:open, ws.object_id]
        @clients << ws
        # loop do
        #   @clients.each {|client| client.send(JSON.dump "hello this is a message")}
        #   sleep(30)
        # end
        # open connection to twitter for every new client
      end

      ws.on :close do |event|
        p [:close, ws.object_id, event.code, event.reason]
        @clients.delete(ws)
        ws = nil
      end

      ws.rack_response
    else
      # [200, {'Content-Type' => 'text/plain'}, ["Clap for Ashley"]]
      @app.call(env)
    end
  end
end