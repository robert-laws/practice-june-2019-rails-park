class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.all
  end

  def show
    @attraction = Attraction.find(params[:id])
    @ride = Ride.new
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.new(attraction_params)

    if @attraction.save
      flash[:notice] = "New attraction added."
      redirect_to attraction_path(@attraction)
    else
      render :new
    end
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def update
    @attraction = Attraction.find(params[:id])

    if @attraction.update_attributes(attraction_params)
      flash[:notice] = "Attraction updated."
      redirect_to attraction_path(@attraction)
    else
      render :edit
    end
  end

  def destroy
    @attraction = Attraction.find(params[:id])
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
  end
end