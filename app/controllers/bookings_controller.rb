class BookingsController < ApplicationController

before_action :set_booking, only: [:edit, :update, :destroy]

  def create
    @booking = Booking.new
    event = Event.find(params[:event_id].to_i)
    @booking.event = event
    @booking.user = current_user
    @booking.status = false

    authorize @booking

    if @booking.save!
      EventChannel.broadcast_to(
      event,
      render_to_string(partial: "booking", locals: { booking: @booking })
    )
      redirect_to dashboard_url({classbook:"active", classevent:"d-none", classeventtab: " ", classbooktab: "active" })
    else
      render "events/show"
    end

  end

  def edit
  end

  def update
    @booking.update(booking_params)
    authorize @booking
    if @booking.save!
       EventChannel.broadcast_to(
      @booking.event,
      {status: @booking.status}
    )
      redirect_to dashboard_url({classbook:"active", classevent:"d-none", classeventtab: " ", classbooktab: "active" }), notice: "New booking was updated"
    else
      render :edit
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to dashboard_url({classbook:"active", classevent:"d-none", classeventtab: " ", classbooktab: "active" }), notice: "Booking was cancelled"
  end

  private
  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:status)
  end
end
