require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  def find_artist
    Artist.all.find(params[:id])
  end

  get "/" do
    @artists = Artist.all
    erb :welcome
  end

  get "/artists" do
    @artists = Artist.all
    erb :index
  end

  get "/artists/new" do
    erb :new
  end

  get "/artists/:id" do
    @artist = find_artist
    erb :show
  end

  get "/artists/:id/edit" do
    @artist = find_artist
    erb :edit
  end

  get "/artists/:id/delete" do
    @artist = find_artist
    erb :delete
  end

  post "/artists" do
    p params
    @artist = Artist.create(params)
    redirect to "/artists/#{@artist.id}"
  end

  patch "/artists/:id" do
    params.delete("_method")
    @artist = find_artist
    @artist.update(params)
    redirect to "/artists/#{@artist.id}"
  end

  delete "/artists/:id" do
    @artist = find_artist
    @artist.destroy
    redirect to "/artists"
  end

end
