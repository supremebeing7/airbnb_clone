class RatingsController < ApplicationController

  def create
    @rating = Rating.create(ratings_params)
    respond_to do |format|
      format.html { redirect_to room_path(@rating.room), notice: "Rated!" }
      format.js
    end
  end

private

  def ratings_params
    params.require(:rating).permit(:stars, :room_id, :user_id, :review)
  end
end
