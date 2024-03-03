import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="refreshless"
export default class extends Controller {

  static targets = ["display","plannercard","colorswatch"]


  connect() {
    console.log("connected")
    // window.onscroll = function() {scrollFunction()};
    // function scrollFunction() {
    //   if (document.body.scrollTop > 80 || document.documentElement.scrollTop > 80) {
    //     document.getElementById("colorarea").style.height = "50px";
    //   } else {
    //     document.getElementById("colorarea").style.height = "200px";
    //   }
    // }
  }

  add(event) {
    event.preventDefault();
    console.log("An item is added to planner")
    console.log(event.currentTarget);
    fetch(event.currentTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(event.currentTarget)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data.colorswatch)
        console.log(this.displayTarget)
        this.displayTarget.insertAdjacentHTML("beforeend", data.html)
        this.colorswatchTarget.outerHTML = data.colorswatch
      })

  }

  remove(event) {
    event.preventDefault();
    console.log("An item is deleted from planner");
    console.log(this.removeitemTargets)
    const plannercard = event.currentTarget.parentElement.parentElement.parentElement
    console.log(plannercard)
    fetch(event.currentTarget.action, {
      method: "DELETE",
      body: new FormData(event.currentTarget)
    })
    .then(response => {
      if (response.ok) {
        console.log("Item deleted successfully");
        plannercard.remove();
        return response.json();
      } else {
        console.error("Failed to delete item:", response.statusText);
        // Handle the case where the delete request was not successful
      }
    })

    .then(data => {
      console.log(data.colorswatch)
      this.colorswatchTarget.outerHTML = data.colorswatch
    })


  }
}
