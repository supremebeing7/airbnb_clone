class PicturesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      flash[:notice] = "Thanks for adding a new picture!"
      redirect_to room_path(@picture.room)
    else
      render new_picture_path
    end
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      flash[:notice] = 'Picture Updated'
      redirect_to picture_path(@picture)
    else
      flash[:notice] = 'Failed to Update'
      redirect_to :back
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    flash[:notice] = "Picture Deleted"
    redirect_to logout_path
  end

private
  def picture_params
    params.require(:picture).permit(:image, :caption, :room_id)
  end
end
