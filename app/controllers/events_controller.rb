class EventsController < ApplicationController
  def index
    @users = User.all
    if params[:commit].present?
      @events = policy_scope(Event).where(level: params[:level]).where(sport: params[:sport]).where(date: params[:date])
    else
      @events = policy_scope(Event)
      puts "No available matches, try another search!"
    end
  end

  def show
    @bookings = Booking.all
  end



end
