class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to ('/logs')
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:email] != "" && params[:password] != ""
      @user = User.create(:email => params[:email], :password => params[:password])
      session[:id] = @user.id
      redirect to ('/logs')
    else
      redirect to ('/signup')
    end
  end

  get '/login' do
    if logged_in?
      redirect to ('/logs')
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:email => params[:email])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/logs'
    else
      redirect to ('/login')
    end
  end

  
end
