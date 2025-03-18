import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="initial-questions-sidebar"
export default class extends Controller {
  static targets = ["sidebar", "flexbox", "title", "card"];

  connect() {
    console.log("InitialQuestionsSidebar controller connected");
  }

  toggleSidebar() {
    this.sidebarTarget.classList.toggle("hidden");
    this.flexboxTarget.classList.toggle("flexwrap");
    this.cardTargets.forEach((card) => {
      card.classList.toggle("flip-card-row");
      card.classList.toggle("flip-card-column");
    });
    this.titleTarget.classList.toggle("title");
  }
}

// refersh button - clicked should open sidebar
// x in side bar should close sidebar
// clicking outside sidebar should close sidebar
// change card html from no wrap to wrap
