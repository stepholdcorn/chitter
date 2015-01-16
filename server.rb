require 'sinatra/base'
require 'data_mapper'

class Chitter < Sinatra::Base

	env = ENV['RACK_ENV'] || 'development'

	DataMapper.setup(:default, "postgres://localhost:5432/chitter_#{env}")
	require './lib/peep'

	DataMapper.finalize
	DataMapper.auto_upgrade!

  get '/' do
    @peeps = Peep.all
    erb :index
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
