class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    erb :index
  end
  get '/recipes/new' do
    erb :new
  end
  get '/recipes/:id' do
    @recipe1 = get_from_all
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = get_from_all
    erb :edit
  end

  post '/recipes' do
    @recipe = Recipe.create(:name => params[:name],:ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end

  patch '/recipes/:id' do
    @recipe = get_from_all
    @recipe.update(:name => params[:name],:ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = get_from_all
    @recipe.destroy()
  end
  
  def get_from_all
    Recipe.all.where("id = ?",params[:id])[0]
  end


end
