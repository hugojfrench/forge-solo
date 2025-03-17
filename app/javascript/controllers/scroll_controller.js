import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["feedbacks"]

  connect() {
    console.log("connected");
  }

  scrollToFeedbacks() {
    if (this.feedbacksTarget) {
      this.feedbacksTarget.scrollIntoView({ behavior: "smooth" });
    }
  }
}
