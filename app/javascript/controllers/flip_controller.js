import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flip"
export default class extends Controller {
  static targets = ["card"]

  connect() {
    // console.log("Hello, flip!")
    this.flipCardsWithDelay();
  }

  flipCardsWithDelay() {
    // console.log("Flipping cards with delay");
    this.cardTargets.forEach((card, index) => {
      setTimeout(() => {
        card.classList.toggle("flipped");
      }, index * 1000);
    }
    );
  }
}
