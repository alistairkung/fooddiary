ENV['RACK_ENV'] ||= "development"
require 'dotenv'
require 'sinatra/base'
require 'aws-sdk'

require_relative './controllers/controller'

Dotenv.load

class App < Sinatra::Base
  run! if app_file == $0
end
