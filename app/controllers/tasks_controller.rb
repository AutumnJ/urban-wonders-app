class TasksController < ApplicationController
  get '/tasks' do
    if logged_in?
      @tasks = Task.all
    erb :'tasks/tasks'
    else
      redirect to '/login'
    end
  end

  get '/tasks/new' do
    if logged_in?
      erb :'tasks/create_task'
    else
      redirect to '/login'
    end
  end

end
