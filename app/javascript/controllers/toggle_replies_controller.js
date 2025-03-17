import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-replies"
export default class extends Controller {
  connect() {
    console.log("ToggleReplies controller connected");
  }

  
}
