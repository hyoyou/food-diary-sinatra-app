class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to ('/logs')
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:email] != "" && params[:password] != "" && !User.find_by(email: params[:email])
      @user = User.create(:email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect to ('/logs')
    else
      flash[:notice] = "Please make sure form was filled out correctly!"
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
      session[:user_id] = @user.id
      redirect '/logs'
    else
      flash[:notice] = "Please check log in credentials."
      redirect to ('/login')
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:notice] = "Successfully logged out!"
      redirect to ('/login')
    else
      redirect '/'
    end
  end

end
