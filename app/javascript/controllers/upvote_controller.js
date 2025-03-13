import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upvote"
export default class extends Controller {
  connect() {
    console.log("✅ Upvote controller connected!");
  }
}
