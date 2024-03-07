import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"
// Connects to data-controller="loadingpage"
export default class extends Controller {
  connect() {
      setTimeout(this.showPage, 7000);
  }
  showPage() {
    if (document.querySelector(".loader-container")) {
      document.querySelector(".loader-container").style.display = "none";
    }
  }

}
