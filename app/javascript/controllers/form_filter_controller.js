import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-filter"
export default class extends Controller {
  prepare(event) {
    // Find all excluded sections inside this form and remove them before submit
    const excludedSections = this.element.querySelectorAll(".post-section-wrapper.excluded")
    excludedSections.forEach(section => section.remove())
  }
}
