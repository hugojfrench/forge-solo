import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="section-remove"
export default class extends Controller {
  static targets = ["wrapper"]

  toggle(event) {
    event.preventDefault()
    this.wrapperTarget.classList.toggle("excluded") // Add/remove 'excluded' class
  }
}
