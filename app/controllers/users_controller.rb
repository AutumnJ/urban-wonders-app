class UsersController < ApplicationController
  use Rack::Flash

  get 'users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if logged_in?
      erb :'users/show'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
    redirect to "/signup"
    else
      @user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
      @user.save
      session[:user_id] = @user.id
      erb :'users/show'
    end
  end

  get '/login' do
    if logged_in?
      erb :'users/show'
    else
    erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      erb :'users/show'
    else
      redirect to "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to "/login"
    else
      redirect to "/"
    end
  end

end
