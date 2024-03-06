import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="colorscheme"
export default class extends Controller {
  static targets = ["usercolor", "displayArea"];

  connect() {
    console.log("js connected");
  }

  roomchecking(event){
    console.log("room is connected");
  }

  select(event) {
    event.preventDefault();
 // resetting the others to zero
    const allDivs = document.querySelectorAll('.scheme-card');
    allDivs.forEach(div => {
      div.style.border = '0';
      const allInputs = div.querySelectorAll('input[type="color"]');
      allInputs.forEach(input => {
          input.setAttribute("name", "");
      });
  });
// picking the current one only
    const selectedDiv = event.currentTarget.parentElement
    selectedDiv.style.border = "2px solid white";
    const selectedInput = selectedDiv.querySelectorAll('input[type="color"]')
    selectedInput.forEach(element => {element.setAttribute("name", "room[palette][]")});
}


  suggestion(event){
    this.displayAreaTarget.innerHTML = ""; // reset everthing
    console.log("color is connected");
    const usercolor = this.usercolorTarget.value.slice(1);
    console.log(usercolor);
    const modes = ["analogic", "monochrome", "monochrome-light", "quad"];
    const schemeButton = `<button data-action="click->colorscheme#select">Pick this color scheme</button>`;

 // iteration
 modes.forEach(mode => {
  this.displayAreaTarget.insertAdjacentHTML('beforeend', `<div id="${mode}" class="scheme-card col-lg-6 col-md-6 col-sm-12 mb-8"></div>`);
  const modeDiv = document.getElementById(mode);
  modeDiv.insertAdjacentHTML('beforeend', `<p>${mode}</p>`);
  fetch(`https://www.thecolorapi.com/scheme?hex=${usercolor}&format=json&mode=${mode}&count=5`)
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      const scheme = data.colors;
      scheme.forEach(color => {
        const colorHex = color.hex.value;
        const colorPicker = `<input type="color" name="" value="${colorHex}">`;
        modeDiv.insertAdjacentHTML('beforeend',colorPicker);
      });
  modeDiv.insertAdjacentHTML('beforeend',schemeButton)
    })
});
  }

}
