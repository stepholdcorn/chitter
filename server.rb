require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'

class Chitter < Sinatra::Base

	env = ENV['RACK_ENV'] || 'development'

	DataMapper.setup(:default, "postgres://localhost:5432/chitter_#{env}")
	require './lib/cheep'
	require './lib/user'

	DataMapper.finalize
	DataMapper.auto_upgrade!

	enable :sessions
	set :session_Secret, 'super secret'
	use Rack::Flash

  get '/users/new' do
  	@user = User.new
  	erb :'users/new'
  end

  post '/users' do
  	@user = User.create(name: params[:name],
  				handle: params[:handle],
  				email: params[:email],
  				password: params[:password],
  				password_confirmation: params[:password_confirmation])
  	if @user.save
  		session[:user_id] = @user.id
  		redirect '/'
  	else
  		flash.now[:errors] = @user.errors.full_messages
  		erb :'users/new'
  	end
  end

  get '/' do
    @cheeps = Cheep.all
    erb :index
  end

  post '/cheeps' do
  	content = params[:content]
  	Cheep.create(content: content)
  	redirect '/'
  end

  helpers do

  	def current_user
  		@current_user ||= User.get(session[:user_id]) if session[:user_id]
  	end

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
