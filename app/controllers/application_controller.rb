require './config/environment'
require 'sinatra/base'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  helpers do
    def current_user
      User.find(session[:id]) if logged_in?
    end

    def logged_in?
      !!session[:id]
    end
  end

end
