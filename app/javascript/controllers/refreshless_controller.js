import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="refreshless"
export default class extends Controller {

  static targets = ["form", "display","removeitem","plannercard"]

  connect() {
    console.log("connected")
  }

  add(event) {
    event.preventDefault();
    console.log("An item is added to planner")
    console.log(event.currentTarget);
    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(event.currentTarget)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data.html)
        console.log(this.displayTarget)
        this.displayTarget.insertAdjacentHTML("beforeend", data.html)
      })
  }

  remove(event) {
    event.preventDefault();
    console.log("An item is deleted from planner");
    console.log(event.currentTarget);
    console.log(this.removeitemTarget.action)
    fetch(this.removeitemTarget.action, {
      method: "DELETE",
      body: new FormData(event.currentTarget)
    })
    .then(response => {
      if (response.ok) {
        console.log("Item deleted successfully");
        console.log(this.removeitemTarget);
        this.plannercardTarget.remove();
      } else {
        console.error("Failed to delete item:", response.statusText);
        // Handle the case where the delete request was not successful
      }
    })
  //     .then((data) => {

  //     })
  }
}
