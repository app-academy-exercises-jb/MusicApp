class AlbumsController < ApplicationController
  def new
    @album = Album.new
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
    album()
    return redirect_to(band_url(params.require(:id))) unless @album
    render :show
  end

  def edit
    album()
    return redirect_to(band_url(params.require(:id))) unless @album

    render :edit
  end

  def destroy
    album()
    return redirect_to(band_url(params.require(:id))) unless @album
    @album.destroy!
    redirect_to band_url(@album.band_id)
  end

  def update
    album()
    return redirect_to(band_url(params.require(:id))) unless @album
    if @album.update_attributes(album_params)
      redirect_to album_url(@album.id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  private
  def album
    @album ||= Album.find(params.require(:id))
  end
  def album_params
    prms = params.require(:album).permit(:band_id, :title, :year, :studio)
    prms[:studio] = prms[:studio] == "studio" ? true : false
    prms
  end
end
