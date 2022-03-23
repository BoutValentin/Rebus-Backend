import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["alert"];

  click() {
    this.alertTarget.style.display = "none";
  }
}
