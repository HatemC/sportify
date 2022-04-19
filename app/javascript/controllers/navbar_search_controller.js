import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["searchbox"]

  displaySearch(event) {
    event.preventDefault();
    this.searchboxTarget.classList.remove("d-none");
  }

}
