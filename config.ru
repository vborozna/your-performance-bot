require "bundler"
Bundler.require(:default)
require_all "lib"
require_all "config"

Rack::CommonLogger
run Bot::Base.new
