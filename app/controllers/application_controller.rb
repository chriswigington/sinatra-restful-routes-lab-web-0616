class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  # CREATE
  get '/recipes/new' do 
    erb :new
  end

  post '/recipes' do 
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    @recipe_id = @recipe.id 
    puts @recipe_id
    redirect to "/recipes/#{@recipe_id}"
  end

  # UPDATE
  get '/recipes/:id/edit' do 
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  post '/recipes/:id' do
    Recipe.update(params[:id], name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to get "/recipes/:id"
  end

  # SHOW our index, all recipes
  get '/recipes' do 
    @recipes = Recipe.all
    erb :index
  end

  # SHOW a specific recipe
  get '/recipes/:id' do 
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  # DELETE
  post '/recipes/:id/delete' do 
    @recipe_name = Recipe.find(params[:id])
    Recipe.delete(params[:id])
  end

  get '/' do
    redirect to '/recipes'
  end
end