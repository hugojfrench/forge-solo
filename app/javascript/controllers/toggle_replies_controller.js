import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-replies"
export default class extends Controller {
  static targets = ["replies"]

  connect() {
    console.log("ToggleReplies controller connected");
  }

  toggle() {
    this.repliesTarget.classList.toggle("hidden");
}
