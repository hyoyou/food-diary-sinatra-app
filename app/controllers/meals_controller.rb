class MealsController < ApplicationController

  get '/meals' do
    if logged_in? && current_user
      @user = current_user
      @meals = Meal.all
      erb :'/meals/meal_index'
    else
      redirect to '/login'
    end
  end

  get '/meals/new' do
    if current_user
      erb :'/meals/new_meal'
    else
      redirect to '/login'
    end
  end

  post '/meals' do
    if params[:name] != "" && params[:calories] != ""
      current_user.meals.create(:name => params[:name], :calories => params[:calories])
      redirect to '/meals'
    else
      redirect to '/meals/new'
    end
  end

  get "/meals/:id" do
    @meal = Meal.find(params[:id])
    if current_user
      erb :'meals/show_meal'
    else
      redirect '/login'
    end
  end


end
