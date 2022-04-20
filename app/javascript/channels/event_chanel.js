import consumer from "./consumer";

const initEventCable = () => {
  const bookingsContainer = document.querySelectorAll('.events');
  if (bookingsContainer) {
    bookingsContainer.forEach( (booking) => {
      const id = booking.dataset.eventId;
      consumer.subscriptions.create({ channel: "EventChannel", id: id }, {
        received(data) {
          booking.insertAdjacentHTML('beforeend', data);; // called when data is broadcast in the cable
        },
      });
    })

  }
  const bookingConfirmation = document.getElementById('bookAccept');
    if (bookingConfirmation) {
      const id = bookingConfirmation.dataset.bookingId;
      consumer.subscriptions.create({ channel: "EventChannel", id: id}, {
        received(data) {
          console.log(data)
          document.getElementById('confirmation-book').innerText = 'status: booked' ;
        },
      });
    }
}

export { initEventCable };
