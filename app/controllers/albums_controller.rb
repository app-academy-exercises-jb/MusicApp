class AlbumsController < ApplicationController
  before_action :ensure_album, except: [:new, :create]

  def new
    @band = Band.find(params.require(:band_id))
    @album = Album.new(band_id: @band.id)
    
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end
  
  def show
    render :show
  end

  def edit
    render :edit
  end

  def destroy
    @album.destroy!
    redirect_to band_url(@album.band_id)
  end

  def update
    if @album.update_attributes(album_params)
      redirect_to album_url(@album.id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  private
  def ensure_album
    album()
    return redirect_to(band_url(params.require(:id))) unless @album
  end

  def album
    @album ||= Album.find(params.require(:id))
  end
  def album_params
    prms = params.require(:album).permit(:band_id, :title, :year, :studio)
    prms[:studio] = prms[:studio] == "studio" ? true : false
    prms
  end
end
