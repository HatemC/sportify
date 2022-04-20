class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @booking = Booking.new
    if params[:query].present?
      @events = policy_scope(Event).where("sport ILIKE ?", "%#{params[:query]}%")
    else
      @events = policy_scope(Event)
    end

    if params[:sports].present?
      @events = @events.where("sport ILIKE ?", "%#{params[:sports]}%") if params[:sports]
    else
      @events = @events.all
    end

    @users = User.all
    @events = @events.where(level: params[:level]) if params[:level].present?
    @events = @events.where(sport: params[:sport]) if params[:sport].present?
    @events = @events.where("date >= '#{params[:start_date]}'") if params[:start_date].present?
    @events = @events.where("date <= '#{params[:end_date]}'") if params[:end_date].present?
    @markers = @events.map do |event|
    {
      lat: event.latitude,
      lng: event.longitude,
      infoWindow: render_to_string(partial: "events/map_box", locals: { event: event }),
      id: event.id
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
      redirect_to dashboard_path({classbook:"d-none", classevent:"active", classeventtab: "active", classbooktab: " " }), notice: "Your event was created! On fire #{current_user.first_name} !"
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
      redirect_to dashboard_url({classbook:"d-none", classevent:"active", classeventtab: "active", classbooktab: " " }), notice: "Your event was updated "
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to dashboard_url({classbook:"d-none", classevent:"active", classeventtab: "active", classbooktab: " " }), notice: "The event was removed, keep an eye on other new events in Sportify!"
  end

  private

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end


  def event_params
    params.require(:event).permit(:sport, :level, :date, :duration, :address, :event_name, :photo, :description)
  end
end
