import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
  console.log(this.show-eventTarget);
  }

  show() {
    redirect_to event_path(event.id);

  }

}
