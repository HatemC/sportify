import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["contact","label"]

  newContact(event) {
    event.preventDefault();
    this.contactTarget.classList.remove("d-none");
  }

  highlight(event) {
    event.preventDefault();
    this.labelTarget.classList.add("active");
  }

}
