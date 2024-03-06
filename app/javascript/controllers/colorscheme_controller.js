import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="colorscheme"
export default class extends Controller {
  static targets = ["usercolor"];

  connect() {
    console.log("js connected");
  }
  roomchecking(event){
    console.log("room is connected");
  }
  suggestion(event){
    console.log("color is connected");
    const usercolor = this.usercolorTarget.value.slice(1);
    console.log(usercolor);
  }
}
