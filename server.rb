require 'sinatra/base'
require 'data_mapper'

class Chitter < Sinatra::Base

	env = ENV['RACK_ENV'] || 'development'

	DataMapper.setup(:default, "postgres://localhost:5432/chitter_#{env}")
	require './lib/cheep'

	DataMapper.finalize
	DataMapper.auto_upgrade!

  get '/' do
    @cheeps = Cheep.all
    erb :index
  end

  post '/cheeps' do
  	content = params[:content]
  	Cheep.create(content: content)
  	redirect '/'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
