import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="colorscheme"
export default class extends Controller {
  static targets = ["usercolor", "displayArea","room","title"];

  connect() {
    console.log("js connected");
  }

  roomchecking(event){
    event.preventDefault();
    console.log("room is connected");
    // resetting the others to zero
    const allRooms = document.querySelectorAll('.room-card');
    allRooms.forEach(room => {
      room.classList.remove("clicked");
      this.roomTarget.value = "";
  });

    // passing the roomtype to simple form
    const roomtype = event.currentTarget.getAttribute('data-roomtype');
    console.log(roomtype)
    this.roomTarget.value = roomtype;
    console.log(this.roomTarget.value)
    event.currentTarget.classList.add("clicked");

  }

  select(event) {
    event.preventDefault();
 // resetting the others to zero
    const allDivs = document.querySelectorAll('.scheme-card');
    allDivs.forEach(div => {
      div.classList.remove("clicked");
      const allInputs = div.querySelectorAll('input[type="color"]');
      allInputs.forEach(input => {
          input.setAttribute("name", "");
      });
  });
// picking the current one only
    // const selectedDiv = event.currentTarget.parentElement
    const id = event.currentTarget.id.slice(4);
    const selectedDiv = document.getElementById(id);
    selectedDiv.classList.add("clicked");
    const selectedInput = selectedDiv.querySelectorAll('input[type="color"]')
    selectedInput.forEach(element => {element.setAttribute("name", "room[palette][]")});
}


  suggestion(event){
    this.titleTarget.innerHTML = "<p>Suggested Color Schemes: </p>";
    this.displayAreaTarget.innerHTML = ""; // reset everthing
    console.log("color is connected");
    const usercolor = this.usercolorTarget.value.slice(1);
    console.log(usercolor);
    const nameOnColorAPI = ["analogic", "monochrome", "monochrome-light", "quad"];
    const funnyNames = ["Analogic", "Monochrome", "Monochrome-light", "Quad"];
    const modes = {};

    nameOnColorAPI.forEach((mode, index) => {
        modes[mode] = funnyNames[index];
    });
 // iteration
 Object.entries(modes).forEach(([mode, funnyName]) => {
  this.displayAreaTarget.insertAdjacentHTML('beforeend', `<div id="${mode}" class="scheme-card"></div>`);// the style is here
  const modeDiv = document.getElementById(mode);
  modeDiv.insertAdjacentHTML('beforeend', `<h5>${funnyName}</h5>`);
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
        const colorPicker = `<input class= "colorpicker" type="color" name="" value="${colorHex}">`;
        modeDiv.insertAdjacentHTML('beforeend',colorPicker);
      });
  modeDiv.insertAdjacentHTML('beforeend',`<button id = "btn-${mode}" data-action="click->colorscheme#select" class="btnColor">Pick this color scheme</button>`)
    })
});
  }

}
