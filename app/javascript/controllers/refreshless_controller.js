import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="refreshless"
export default class extends Controller {

  static targets = ["form"]

  connect() {
    console.log("connected")
  }

  add(event) {
    console.log("An item is added to planner")
  }
}
