import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="filter-tags"
export default class extends Controller {
  static targets = ["form", "select", "currentTags"]

  connect() {
    this.selectTags = new TomSelect(this.selectTarget, {
      maxItems: 3,
      onChange: () => this.submitForm(),
      onItemAdd: (value, $item) => this.addTag($item),
      render: {
        item: function(data, escape) {
          // hide the filter from the search box with 'd-none'
          return `<div class="d-none">${escape(data.text)}</div>`;
        }
      }
    });
  }

  addTag(tag) {
    const newTag = `<div class='tag small'>${tag.innerHTML}</div>`
    this.currentTagsTarget.insertAdjacentHTML("beforeend", newTag);
  }

  submitForm() {
    this.formTarget.requestSubmit();
  }
}
