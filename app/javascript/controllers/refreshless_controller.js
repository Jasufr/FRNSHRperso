import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="refreshless"
export default class extends Controller {

  static targets = ["form", "display","remove"]

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

  // remove(event) {
  //   event.preventDefault();
  //   console.log("An item is deleted from planner");
  //   console.log(event.currentTarget);
  //   console.log(this.removeTarget.href)
  //   fetch(this.removeTarget.href, {
  //     method: "DELETE",
  //     headers: { "Accept": "application/json" }
  //   })
  //     .then(response => {
  //       console.log(response);
  //       response.json()
  //     })
  //     .then((data) => {

  //     })
  // }
}
