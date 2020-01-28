class BandsController < ApplicationController
  def index
    @bands = Band.all
    render :index
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def new
    @band = Band.new
    render :new
  end

  def edit
    band()
    return redirect_to(bands_url) unless @band

    render :edit
  end

  def show
    band()
    return redirect_to(bands_url) unless @band
    render :show
  end

  def update
    band()
    return redirect_to(bands_url) unless @band

    @band.attributes = (band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    band()
    return redirect_to(bands_url) unless @band

    @band.destroy!
    redirect_to bands_url
  end

  private
  def band
    @band ||= Band.find_by(id: params.require(:id))
  end
  def band_params
    params.require(:band).permit(:name)
  end
end
