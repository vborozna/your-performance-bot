require "bundler"
Bundler.require(:default)
require_all "lib"
require_all "config"

run Bot::Base.new
