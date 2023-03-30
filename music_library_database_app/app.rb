# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  # post '/albums' do
  #   repo = AlbumRepository.new
  #   title = params[:title]
  #   release_year = params[:release_year]
  #   artist_id = params[:artist_id]
  #   album = Album.new
  #   album.title = title
  #   album.release_year = release_year
  #   album.artist_id = artist_id
  #   repo.create(album)
  # end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:albums) 
  end

  get '/albums/new' do
    return erb(:new_album)
  end

  post '/albums' do
    @album_name = params[:album_name]
    @album_release = params[:release_year]
    @id_of_artist = params[:artist_id]
    repo = AlbumRepository.new
    album = Album.new 
    album.title = @album_name
    album.release_year = @album_release
    album.artist_id = @id_of_artist
    repo.create(album)
    # if invalid_request_params?
    #   status 400
    #   return ''
    # end
    return erb(:album_created)
  end

  def invalid_request_params?
    return true if params[:album_name] == nil || params[:release_year] == nil || params[:artist_id] == nil
    return true if params[:album_name] == "" || params[:release_year] == "" || params[:artist_id] == ""
    return false
  end

  get '/albums/:id' do
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new

    @album = repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)
    
    return erb(:index)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:artists)
  end

  get '/artists/new' do
    return erb(:new_artist)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])
    
    return erb(:index2)
  end

  post '/artists' do
    @artist_name = params[:artist_name]
    @artist_genre = params[:artist_genre]
    repo = ArtistRepository.new
    artist = Artist.new
    artist.name = @artist_name
    artist.genre = @artist_genre
    repo.create(artist)
    return erb(:created_artist)
  end
end