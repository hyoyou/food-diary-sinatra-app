class MealsController < ApplicationController

  get '/meals' do
    if logged_in? && current_user
      @user = current_user
      @meals = Meal.all
      erb :'/meals/meal_index'
    else
      flash[:notice] = "Please Log In First!"
      redirect to '/login'
    end
  end

  get '/meals/new' do
    if current_user
      erb :'/meals/new_meal'
    else
      flash[:notice] = "Please Log In First!"
      redirect to '/login'
    end
  end

  post '/meals' do
    if params[:name] != "" && params[:calories] != ""
      @meal = current_user.meals.create(:name => params[:name], :calories => params[:calories], :log_id => params[:log_id])
      redirect to "/logs/#{@meal.log_id}"
    else
      flash[:notice] = "Please Make Sure Form Was Filled Out Correctly!"
      redirect to '/meals/new'
    end
  end

  get '/meals/:id' do
    @meal = Meal.find(params[:id])
    if current_user
      erb :'meals/show_meal'
    else
      flash[:notice] = "Please Log In First!"
      redirect '/login'
    end
  end

  get '/meals/:id/edit' do
    @meal = Meal.find(params[:id])
    if @meal.user == current_user
      erb :'/meals/edit_meal'
    else
      flash[:notice] = "Please Log In First!"
      redirect '/login'
    end
  end

  patch '/meals/:id' do
    @meal = Meal.find(params[:id])
    if params[:name] != "" && params[:calories] != ""
      @meal.update(:name => params[:name], :calories => params[:calories])
      @meal.save
      flash[:notice] = "Successfully Updated Meal!"
      redirect "/meals/#{@meal.id}"
    else
      flash[:notice] = "Please Make Sure Form Was Filled Out Correctly!"
      redirect "/meals/#{@meal.id}/edit"
    end
  end

  delete '/meals/:id/delete' do
    @meal = Meal.find(params[:id])
    if @meal.user == current_user
      @meal.destroy
      flash[:notice] = "Successfully Deleted Meal!"
      redirect '/meals'
    else
      flash[:notice] = "Please Log In First!"
      redirect '/login'
    end
  end
  
end
