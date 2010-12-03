#run lambda {Rack::Response.new('Hello').finish}
require 'contacts'
run Sinatra::Application
