class MealsController < ApplicationController

  get '/meals' do
    if logged_in?
      erb :'/meals/index'
    else
      flash[:notice] = "Please log in first!"
      redirect to '/login'
    end
  end

  get '/meals/new' do
    if logged_in?
      erb :'/meals/new_meal'
    else
      flash[:notice] = "Please log in first!"
      redirect to '/login'
    end
  end

  post '/meals' do
    if params[:name] != "" && params[:calories] != ""
      @meal = current_user.meals.create(:name => params[:name], :calories => params[:calories], :log_id => params[:log_id])
      redirect to "/logs/#{@meal.log_id}"
    else
      flash[:notice] = "Please make sure form was filled out correctly!"
      redirect to '/meals/new'
    end
  end

  get '/meals/:id' do
    @meal = Meal.find(params[:id])
    if logged_in? && @meal.user_id == current_user.id
      erb :'meals/show'
    else
      flash[:notice] = "This meal does not belong to the current user. Please check your log in information."
      redirect '/meals'
    end
  end

  get '/meals/:id/edit' do
    @meal = Meal.find(params[:id])
    if logged_in? && @meal.user_id == current_user.id
      erb :'/meals/edit'
    else
      flash[:notice] = "This meal does not belong to the current user. Please check your log in information."
      redirect '/meals'
    end
  end

  patch '/meals/:id' do
    @meal = Meal.find(params[:id])
    if params[:name] != "" && params[:calories] != ""
      @meal.update(:name => params[:name], :calories => params[:calories])
      @meal.save
      flash[:notice] = "Successfully updated meal!"
      redirect "/meals/#{@meal.id}"
    else
      flash[:notice] = "Please make sure form was filled out correctly!"
      redirect "/meals/#{@meal.id}/edit"
    end
  end

  delete '/meals/:id/delete' do
    @meal = Meal.find(params[:id])
    if logged_in? && @meal.user_id == current_user.id
      @meal.destroy
      flash[:notice] = "Successfully deleted meal!"
      redirect '/meals'
    else
      flash[:notice] = "This meal does not belong to the current user. Please check your log in information."
      redirect '/meals'
    end
  end

end
