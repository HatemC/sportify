import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['events','bookings','event','booking']

  showEvents(event) {
    event.preventDefault();
    this.eventsTarget.classList.remove("d-none");
    this.bookingsTarget.classList.add("d-none");
    this.bookingTarget.classList.remove("active");
    this.eventTarget.classList.add("active")

  }

  showBookings(event) {
    event.preventDefault();
    this.eventsTarget.classList.add("d-none");
    this.bookingsTarget.classList.remove("d-none");
    this.eventTarget.classList.remove("active");
    this.bookingTarget.classList.add("active")
  }

}
