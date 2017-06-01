class PicturesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user
  before_filter :find_album
  before_filter :find_picture, :only => [ :show, :edit, :update, :destroy ]
  respond_to :html, :json

  def index
    @pictures = @album.pictures.all

    respond_with(@pictures) do |format|
      format.html { @pictures }
      format.json { render :json => @pictures.as_json }
    end
  end

  def show
    
  end

  def new
    @picture = @album.pictures.new
  end

  def create
    @picture = @album.pictures.build(picture_params)
    @picture.user = current_user

    if @picture.save
      track_activity(@picture)
      respond_with(@picture) do |format|
        format.html { redirect_to album_pictures_path(@album) }
        format.json { render :json => @picture.as_json }
      end
    else
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def destroy
    untrack_activity(@picture)
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to album_pictures_path(@album) }
      format.json { head :no_content }
    end
  end

  def url_options
    { :user_id => params[:user_id] }.merge(super)
  end

  private

  def find_user
    @user = User.friendly.find(params[:user_id])
  end

  def find_album
    @album = @user.albums.find(params[:album_id])
  end

  def find_picture
    @picture = @album.pictures.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:caption, :description, :picture)
  end
end
