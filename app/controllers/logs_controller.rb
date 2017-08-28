class LogsController < ApplicationController
  get '/logs' do
    erb :'logs/log_index'
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
  
end
