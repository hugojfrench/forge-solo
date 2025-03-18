import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="filter-tags"
export default class extends Controller {
  static targets = ["form", "select", "currentTags"]

  connect() {
    this.selectTags = new TomSelect(this.selectTarget, {
      maxItems: 3,
      placeholder: "Search...",
      onChange: () => this.submitForm(),
      onItemAdd: (value, $item) => this.itemAdded($item),
      render: {
        item: function(data, escape) {
          // hide the filter from the search box with 'd-none'
          return `<div class="d-none">${escape(data.text)}</div>`;
        }
      }
    });
  }

  itemAdded(tag) {
    this.insertTag(tag);
    this.updateSelectTags();
  }

  updateSelectTags() {
    if (this.selectTags.settings.maxItems === this.selectTags.items.length) {
      this.selectTags.settings.placeholder = "Remove a filter";
      this.selectTags.blur();
    }
  }

  insertTag(tag) {
    const newTag = `<div class='tag small'>
      ${tag.innerHTML}
      <span data-action='click->filter-tags#removeItem'><i class="fa-solid fa-x"></i></span>
      </div>`
    this.currentTagsTarget.insertAdjacentHTML("beforeend", newTag);
  }

  submitForm() {
    this.formTarget.requestSubmit();
  }

  removeItem(event) {
    const domToBeRemoved = event.target.parentElement.parentElement;
    const tagToBeRemoved = domToBeRemoved.innerText.trim();

    let itemValueToBeRemoved = 0;
    Object.keys(this.selectTags.options).forEach( value => {
      if (this.selectTags.options[value]['text'] === tagToBeRemoved) {
        itemValueToBeRemoved = value;
      }
    });

    this.selectTags.removeItem(itemValueToBeRemoved, false);
    domToBeRemoved.remove();
  }
}
