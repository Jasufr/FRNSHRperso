import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="colorscheme"
export default class extends Controller {
  static targets = ["usercolor", "displayAnalogic","analogic","displayMonochrome","monochrome"];

  connect() {
    console.log("js connected");
  }
  selectAnalogic(event) {
    event.preventDefault();
    this.displayAnalogicTarget.style.border = "2px solid white";
    this.analogicTargets.forEach(element => {
      element.setAttribute("name", "room[palette][]");
    });
    this.displayMonochromeTarget.style.border = "";
    this.monochromeTargets.forEach(element => {
      element.setAttribute("name", "");
    });
}

selectMonochrome(event) {
  event.preventDefault();
  this.displayMonochromeTarget.style.border = "2px solid white";
  this.monochromeTargets.forEach(element => {
    element.setAttribute("name", "room[palette][]");
  });
  this.displayAnalogicTarget.style.border = "";
  this.analogicTargets.forEach(element => {
    element.setAttribute("name", "");
  });

}

  roomchecking(event){
    console.log("room is connected");
  }
  suggestion(event){

    console.log("color is connected");
    const usercolor = this.usercolorTarget.value.slice(1);
    console.log(usercolor);
  // 1st color scheme
    this.displayAnalogicTarget.innerHTML = "";
    this.displayAnalogicTarget.insertAdjacentHTML('beforeend',"<p>1st Suggested Color Scheme</p>");
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
    scheme.forEach(color => {
      const colorHex = color.hex.value;
      console.log(colorHex); // This will log the hexcode of each color
      const colorPicker = `<input type="color" data-colorscheme-target="analogic" name="" value="${colorHex}">`;
      this.displayAnalogicTarget.insertAdjacentHTML('beforeend',colorPicker);
    });
const analogicButton = `<button data-action="click->colorscheme#selectAnalogic">Pick this color scheme</button>`;
this.displayAnalogicTarget.insertAdjacentHTML('beforeend',analogicButton)
  })

// 2nd color scheme
this.displayMonochromeTarget.innerHTML = "";
this.displayMonochromeTarget.insertAdjacentHTML('beforeend',"<p>2nd Suggested Color Scheme</p>");
  fetch(`https://www.thecolorapi.com/scheme?hex=${usercolor}&format=json&mode=monochrome&count=5`)
  .then(response => {
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    return response.json();
  })
  .then(data => {
    console.log(data); // This will return an long array
    const scheme = data.colors;
    scheme.forEach(color => {
      const colorHex = color.hex.value;
      console.log(colorHex); // This will log the hexcode of each color
      const colorPicker = `<input type="color" data-colorscheme-target="monochrome" name="" value="${colorHex}">`;
      this.displayMonochromeTarget.insertAdjacentHTML('beforeend',colorPicker);
    });
const monochromeButton = `<button data-action="click->colorscheme#selectMonochrome">Pick this color scheme</button>`;
this.displayMonochromeTarget.insertAdjacentHTML('beforeend',monochromeButton)
  })

// reset the selector to not selected
  this.displayAnalogicTarget.style.border = "";
  this.analogicTargets.forEach(element => {
    element.setAttribute("name", "");
  });
  this.displayMonochromeTarget.style.border = "";
  this.monochromeTargets.forEach(element => {
    element.setAttribute("name", "");
  });
  }


}
