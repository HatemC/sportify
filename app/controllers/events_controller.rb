class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy]

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
    @booking = Booking.new
    @events = Event.where(sport: @event.sport)
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    authorize @event
    if @event.save!
      redirect_to events_path, notice: "event was created"
    else
      render :new
    end
  end

  def edit
    authorize @event
  end

  def update
    @event.update(event_params)

    if @event.save!
      redirect_to @event, notice: "Your event was updated"
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: "event was destroyed"
  end

  private

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  def event_params
    params.require(:event).permit(:sport, :level, :date, :duration, :address)
  end
end
