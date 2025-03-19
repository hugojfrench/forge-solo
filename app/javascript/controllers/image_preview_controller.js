import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview", "label"]

  preview() {
    const file = this.inputTarget.files[0]
    if (file) {
      const reader = new FileReader()
      reader.readAsDataURL(file)
      reader.onload = (event) => {
        this.previewTarget.src = event.target.result
        this.labelTarget.classList.add("d-none");
        this.previewTarget.classList.remove("d-none");
      }
    }
  }
}
