class LogsController < ApplicationController

  get '/logs' do
    if logged_in?
      @user = current_user
      @log = Log.all
      erb :'logs/log_index'
    else
      flash[:notice] = "Please Log In First!"
      redirect to '/login'
    end
  end

  get '/logs/new' do
    if current_user
      erb :'logs/new_log'
    else
      flash[:notice] = "Please Log In First!"
      redirect to '/login'
    end
  end

  post '/logs' do
    if params[:date] != ""
      current_user.logs.create(:date => params[:date])
      redirect to '/meals/new'
    else
      flash[:notice] = "Please Make Sure Form Was Filled Out Correctly!"
      redirect to '/logs/new'
    end
  end

  get '/logs/:id' do
    @log = Log.find(params[:id])
    if current_user && @log.user_id == current_user.id
      erb :'logs/show_log'
    else
      flash[:notice] = "This log does not belong to the current user. Please check your log in information."
      redirect to '/logs'
    end
  end

  get '/logs/:id/edit' do
    if current_user && @log.user_id == current_user.id
      @log = Log.find(params[:id])
      erb :'/logs/edit_log'
    else
      flash[:notice] = "This log does not belong to the current user. Please check your log in information."
      redirect '/logs'
    end
  end

  patch '/logs/:id' do
    @log = Log.find(params[:id])
    if params[:date] != ""
      @log.date = params[:date]
      @log.save
      flash[:notice] = "Successfully Updated Log!"
      redirect to "/logs/#{@log.id}"
    else
      flash[:notice] = "Please Make Sure Form Was Filled Out Correctly!"
      redirect to "/logs/#{@log.id}/edit"
    end
  end

  delete '/logs/:id/delete' do
    @log = Log.find(params[:id])
    if current_user && @log.user_id == current_user.id
      @meal = Meal.find_by(:log_id => params[:id])
      if @meal.present?
        @meal.destroy
        @log.destroy
        flash[:notice] = "Successfully Deleted Log!"
        redirect '/logs'
      else
        @log.destroy
        flash[:notice] = "Successfully Deleted Log!"
        redirect '/logs'
      end
    else
      flash[:notice] = "This log does not belong to the current user. Please check your log in information."
      redirect '/logs'
    end
  end

end
