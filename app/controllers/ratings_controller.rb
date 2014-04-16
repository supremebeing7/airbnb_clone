class RatingsController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @user = User.find(params[:user_id])
    Rating.create(user_id: @user.id, room_id: @room.id, ratings_params)
    redirect_to room_path(@room), notice: "Rated!"
  end

  private

  def ratings_params
    params.require(:rating).permit(:stars)
  end
end
