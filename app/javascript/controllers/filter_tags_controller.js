import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="filter-tags"
export default class extends Controller {
  connect() {
    console.log("I have a connection");
    console.log(this.element);
    
    new TomSelect(this.element, { maxItems: 3 });
  }
}
