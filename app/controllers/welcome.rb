class App < Sinatra::Base
  get '/' do
    content_type :json
  end
end
