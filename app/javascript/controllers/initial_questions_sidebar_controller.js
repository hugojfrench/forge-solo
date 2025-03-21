import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="initial-questions-sidebar"
export default class extends Controller {
  static targets = ["sidebar", "flexbox", "title", "card"];

  connect() {
    console.log("InitialQuestionsSidebar controller connected");
    console.log(this.flexboxTarget.children);

  }

  toggleSidebar() {
    this.sidebarTarget.classList.toggle("hidden");
    this.flexboxTarget.classList.toggle("l-sidebar-active");
    // have added the below line to iterate through form elements to change widths
    Array.from(this.flexboxTarget.children).forEach((form) => {
      form.classList.toggle("l-card-horizontal")
    })
    this.titleTarget.classList.toggle("title");
  }
}

// refersh button - clicked should open sidebar
// x in side bar should close sidebar
// clicking outside sidebar should close sidebar
// change card html from no wrap to wrap
