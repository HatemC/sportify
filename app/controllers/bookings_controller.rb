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
      redirect_to dashboard_url, notice: "New booking was created"

    end
  end

  def edit
  end

  def update
    @booking.update(booking_params)
    authorize @booking
    if @booking.save!
      redirect_to dashboard_url, notice: "New booking was updated"
    else
      render :edit
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to dashboard_url, notice: "Booking was cancelled"
  end

  private
  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:status)
  end
end
