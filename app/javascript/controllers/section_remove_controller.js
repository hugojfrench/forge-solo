import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="section-remove"
export default class extends Controller {
  static targets = ["wrapper"]

  toggle(event) {
    event.preventDefault()
    // event.currentTarget.checked = !event.currentTarget.checked
    this.wrapperTarget.classList.toggle("excluded") // Add/remove 'excluded' class
  }
}
