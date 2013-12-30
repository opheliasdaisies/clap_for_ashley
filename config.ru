require './app.rb'
require './lib/backend'

use Backend

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25

run Ashley::Applause