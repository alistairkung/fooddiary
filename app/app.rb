ENV['RACK_ENV'] ||= "development"

require 'sinatra/base'
require_relative './controllers/welcome'

class App < Sinatra::Base
  run! if app_file == $0
end
