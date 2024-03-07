import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="refreshless"
export default class extends Controller {

  static targets = ["searchDisplay","counter","form","wishlistsubDisplay","statement"]
""

  connect() {
    console.log("connected")
  }

  add(event) {
    event.preventDefault();
    console.log("An item is added to wishlist");
    console.log(event.currentTarget);
    fetch(event.currentTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(event.currentTarget)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(this.wishlistsubDisplayTarget);
        console.log(data.html);
        this.wishlistsubDisplayTarget.insertAdjacentHTML('afterbegin', data.html);
        this.counterTarget.innerText = data.counter
        if(data.counter === 0) {
          this.statementTarget.innerText = "Add some items to your wishlist...";
        } else {
          this.statementTarget.innerText = "";
        }
      })

  }

  // remove(event) {
  //   event.preventDefault();
  //   console.log("An item is deleted from planner");
  //   console.log(this.removeitemTargets)
  //   const plannercard = event.currentTarget.parentElement.parentElement.parentElement
  //   console.log(plannercard)
  //   fetch(event.currentTarget.action, {
  //     method: "DELETE",
  //     body: new FormData(event.currentTarget)
  //   })
  //   .then(response => {
  //     if (response.ok) {
  //       console.log("Item deleted successfully");
  //       plannercard.remove();
  //       return response.json();
  //     } else {
  //       console.error("Failed to delete item:", response.statusText);
  //       // Handle the case where the delete request was not successful
  //     }
  //   })

  // }
}
