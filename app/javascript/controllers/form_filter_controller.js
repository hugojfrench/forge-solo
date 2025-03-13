import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-filter"
export default class extends Controller {
  static targets = ["section"]

  prepare(event) {
    this.sectionTargets.forEach(section => {
      if (section.classList.contains("excluded")) {
        section.remove()
      }
    })
  }
}
