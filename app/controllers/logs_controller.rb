class LogsController < ApplicationController
  get '/logs' do
    if logged_in? && current_user
      @user = current_user
      @log = Log.all
      erb :'logs/log_index'
    else
      redirect to '/login'
    end
  end

  get '/log/new' do
    if current_user
      erb :'logs/new_log'
    else
      redirect to '/login'
    end
  end

  post '/logs' do
    if params[:date] != ""
      current_user.logs.create(:date => params[:date])
      redirect to '/meals/new'
    else
      redirect to '/log/new'
    end
  end

  get '/logs/:id' do
    @log = Log.find(params[:id])
    if current_user
      erb :'logs/show_log'
    else
      redirect to '/login'
    end
  end
end
