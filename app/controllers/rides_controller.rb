class RidesController < ApplicationController
  def create
    @ride = Ride.new(ride_params)
    @user = User.find(params[:ride][:user_id])
    @attraction = Attraction.find(params[:ride][:attraction_id])

    # tickets
    user_tickets = @user.tickets
    attraction_tickets = @attraction.tickets

    # height
    user_height = @user.height
    attraction_min_height = @attraction.min_height

    # happiness
    user_happiness = @user.happiness
    attraction_happiness_rating = @attraction.happiness_rating

    # nausea
    user_nausea = @user.nausea
    attraction_nausea_rating = @attraction.nausea_rating

    flash[:notice] = []

    if helpers.enough_tickets?(user_tickets, attraction_tickets)
      # do nothing
    else
      flash[:notice] << "You do not have enough tickets to ride the #{@attraction.name}"
    end

    if helpers.tall_enough?(user_height, attraction_min_height)
      # do nothing
    else
      flash[:notice] << "You are not tall enough to ride the #{@attraction.name}"
    end

    if helpers.enough_tickets?(user_tickets, attraction_tickets) && helpers.tall_enough?(user_height, attraction_min_height) && @ride.save

      updated_user_tickets = (user_tickets.to_i - attraction_tickets.to_i)
      updated_user_happiness = (user_happiness.to_i + attraction_happiness_rating.to_i)
      updated_user_nausea = (user_nausea.to_i + attraction_nausea_rating.to_i)

      @user.update(tickets: updated_user_tickets, nausea: updated_user_nausea, happiness: updated_user_happiness)

      flash[:notice] << "Thanks for riding the #{@attraction.name}!"
      redirect_to user_path(@user)
    else
      redirect_to user_path(@user)
    end
  end

  private

  def ride_params
    params.require(:ride).permit(:user_id, :attraction_id)
  end
end
