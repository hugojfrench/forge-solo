import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="resize-textarea"
export default class extends Controller {
  connect() {
    this.resize();

    window.addEventListener('resize', () => this.resize());
  }

  checkScrollBarPresent() {
    return this.element.scrollHeight > this.element.clientHeight;
  }

  resize() {
    while (this.checkScrollBarPresent()) {
      this.element.rows = this.element.rows + 1;
    }
  }
}
