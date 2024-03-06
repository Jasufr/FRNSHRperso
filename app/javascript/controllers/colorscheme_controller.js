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
    fetch(`https://www.thecolorapi.com/scheme?hex=${usercolor}&format=json&mode=analogic&count=5`)
  .then(response => {
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    return response.json();
  })
  .then(data => {
    console.log(data); // This will return an long array
    const scheme = data.colors;
    scheme.reverse().forEach(color => {
      const colorHex = color.hex.value;
      console.log(colorHex); // This will log the hexcode of each color
      const colorPicker = "";
      this.usercolorTarget.insertAdjacentHTML('afterend',colorHex)
    });

  })
  }
}
