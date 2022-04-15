class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index

    if params[:query].present?
      @events = Event.where("sport ILIKE ?", "%#{params[:query]}%")
    else
      flash[:notice] = "We don't have the sport yet"
    end


    @users = User.all
    @events = Event.all
    @events = policy_scope(Event)
    @events = @events.where(level: params[:level]) if params[:level]
    @events = @events.where(sport: params[:sport]) if params[:sport]
    @events = @events.where("date >= '#{params[:start_date].split(' ').first}'") if params[:start_date] & @events.where("date <= '#{params[:end_date]}'") if params[:end_date]

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,

        info_window: render_to_string(partial: "info_window", locals: { event: event })
      }
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
      redirect_to dashboard_path, notice: "event was created"
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
    params.require(:event).permit(:sport, :level, :date, :duration, :address, :event_name)
  end
end
