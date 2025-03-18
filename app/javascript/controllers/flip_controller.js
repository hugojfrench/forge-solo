import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flip"
export default class extends Controller {
  connect() {
    console.log("Hello, flip!")
  }
}
