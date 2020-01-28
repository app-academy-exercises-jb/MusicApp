class BandsController < ApplicationController
  before_action :ensure_band, except: [:index, :create, :new]

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
    render :edit
  end

  def show
    render :show
  end

  def update
    @band.attributes = (band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band.destroy!
    redirect_to bands_url
  end

  private
  def ensure_band
    band()
    return redirect_to(bands_url) unless @band
  end
  def band
    @band ||= Band.find_by(id: params.require(:id))
  end
  def band_params
    params.require(:band).permit(:name)
  end
end
