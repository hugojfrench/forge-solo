import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-replies"
export default class extends Controller {
  static targets = ["replies", "button"]

  connect() {
    console.log("ToggleReplies controller connected");
  }

  toggle() {
    this.repliesTarget.classList.toggle("hidden");
    if (this.repliesTarget.classList.contains("hidden")) {
      this.buttonTarget.innerText = "See replies"
    } else {
      this.buttonTarget.innerText = "Hide replies"
    }
  }
}
