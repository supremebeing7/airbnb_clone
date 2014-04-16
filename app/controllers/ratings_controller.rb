class RatingsController < ApplicationController

  def create
    @rating = Rating.create(ratings_params)
    redirect_to room_path(@rating.room), notice: "Rated!"
  end

private

  def ratings_params
    params.require(:rating).permit(:stars, :room_id, :user_id)
  end
end
