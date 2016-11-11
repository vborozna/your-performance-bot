require "bundler"
Bundler.require(:default)
require_all "lib"
require_all "config"
require_relative "seeds"

Rack::CommonLogger
run Bot::Base.new
