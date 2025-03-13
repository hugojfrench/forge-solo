import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upvote"
export default class extends Controller {
  static targets = ["count"]
  static values = { url: String }

  connect() {
    console.log("Upvote controller connected!");
  }

  upvote(event) {
    event.preventDefault();
    // console.log("Upvoting...");

    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        "Accept": "application/json"
      }
    })
      .then(response => {
        if (!response.ok) { throw new Error("Network response was not ok"); }
        return response.json();
      })
      .then(data => {
        this.countTarget.innerText = data.upvotes;
      })
      .catch(error => {
        console.error("Upvote failed:", error);
      });
  }
}
