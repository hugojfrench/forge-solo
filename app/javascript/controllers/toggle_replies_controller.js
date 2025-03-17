import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-replies"
export default class extends Controller {
  static targets = ["replies", "button", "input", "form"]

  connect() {
    console.log("ToggleReplies controller connected");
  }

  toggle() {
    this.repliesTarget.classList.toggle("hidden-replies");
    if (this.repliesTarget.classList.contains("hidden-replies")) {
      this.buttonTarget.innerHTML = this.buttonTarget.dataset.label;
    } else {
      this.buttonTarget.innerText = "Hide replies"
      this.inputTarget.focus();
    }
  }

  submitWithEnter(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault(); // Prevent adding a newline
      this.formTarget.requestSubmit(); // Submits the form properly
    }
  }
}
