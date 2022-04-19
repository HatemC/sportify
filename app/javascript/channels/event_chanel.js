import consumer from "./consumer";

const initEventCable = () => {
  const bookingsContainer = document.querySelectorAll('.events');
  if (bookingsContainer) {
    bookingsContainer.forEach( (booking) => {
      const id = booking.dataset.eventId;
      console.log(booking)
      consumer.subscriptions.create({ channel: "EventChannel", id: id }, {
        received(data) {
          booking.insertAdjacentHTML('beforeend', data);; // called when data is broadcast in the cable
        },
      });
    })

  }
}

export { initEventCable };
