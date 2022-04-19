import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["contact"]

  newContact(event) {
    event.preventDefault();
    this.contactTarget.classList.remove("d-none");

  }

}
