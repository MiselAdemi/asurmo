class AlbumsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_albums, :only => [ :index ]
  before_filter :get_album, :only => [ :show, :destroy ]
  before_filter :set_user
  respond_to :json, :html

  def index
  end

  def show
  end

  def new
    @album = current_user.albums.new
  end

  def create
    @album = current_user.albums.build(albums_params)

    if @album.save
      respond_with(@album) do |format|
        format.html { redirect_to albums_path(current_user) }
        format.json { render :json => @album.as_json }
      end
    else
      respond_with(@album) do |format|
        format.json { render :json => @album.errors }
      end
    end
  end

  def destroy
    @album.destroy
    redirect_to albums_path(current_user)
  end

  def url_options
    { :profile_name => params[:profile_name] }.merge(super)
  end

  private

  def albums_params
    params.require(:album).permit(:title)
  end

  def album_params
    params.permit(:id).require(:id)
  end

  def get_albums
    @albums = current_user.albums
  end

  def get_album
    @album = current_user.albums.find(album_params)
  end

  def set_user
    @user = User.friendly.find(params[:profile_name])
  end
end
