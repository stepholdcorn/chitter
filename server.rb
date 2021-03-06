require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'

class Chitter < Sinatra::Base

	require './lib/cheep'
	require './lib/user'
	require_relative 'data_mapper_setup'

	enable :sessions
	set :session_secret, 'super secret'
	use Rack::Flash
  use Rack::MethodOverride

  get '/users/new' do
  	@user = User.new
  	erb :'users/new'
  end

  before do 
    params.each do |key, value|
      instance_variable_set "@#{key}", value
    end
  end

  post '/users' do
  	@user = User.create(name: @name,
  				handle: @handle,
  				email: @email,
  				password: @password,
  				password_confirmation: @password_confirmation)
  	if @user.save
  		session[:user_id] = @user.id
  		redirect '/'
  	else
  		flash.now[:errors] = @user.errors.full_messages
  		erb :'users/new'
  	end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(@email, @password)
    if user
      session[:user_id] = user.id
      redirect '/'
    else
      flash.now[:errors] = ['The email or password is not correct']
      erb :'sessions/new'
    end
  end

  get '/' do
    @cheeps = Cheep.all
    erb :index
  end

  post '/cheeps' do
  	content = params[:content]
  	cheep = Cheep.new(content: content)
    cheep.user = current_user
    cheep.save
  	redirect '/'
  end

  delete '/sessions' do
    flash[:notice] = 'Good bye'
    session[:user_id] = nil
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
