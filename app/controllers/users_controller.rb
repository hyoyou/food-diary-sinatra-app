class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to ('/logs')
    else
      erb :'users/signup'
    end
  end

end
