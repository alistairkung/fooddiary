ENV['RACK_ENV'] ||= "development"
require 'sinatra/base'
require 'aws-sdk-s3'

require_relative './controllers/controller'

class App < Sinatra::Base
  run! if app_file == $0
end
