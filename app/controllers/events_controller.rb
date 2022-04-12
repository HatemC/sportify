class EventsController < ApplicationController
  def index
    if params[:commit].present?
      @events = policy_scope(Event).where(level: params[:level]).where(sport: params[:sport]).where(data: params[:data])
    else
      @events = policy_scope(Event)
      puts "No available matches, try another search!"
    end
  end

  def show
    @bookings = Booking.all
  end

end
