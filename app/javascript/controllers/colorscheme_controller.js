import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="colorscheme"
export default class extends Controller {
  static targets = ["usercolor", "displayArea","displayAnalogic","displayMonochrome","displayMonochromeLight","displayQuad"];

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
    const schemeButton = `<button data-action="click->colorscheme#select">Pick this color scheme</button>`;

  // 1st color scheme

    this.displayAreaTarget.insertAdjacentHTML('beforeend','<div data-colorscheme-target="displayAnalogic" class = "scheme-card"></div>');
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
      const colorPicker = `<input type="color" name="" value="${colorHex}">`;
      this.displayAnalogicTarget.insertAdjacentHTML('beforeend',colorPicker);
    });
this.displayAnalogicTarget.insertAdjacentHTML('beforeend',schemeButton)
  })

// 2nd color scheme
this.displayAreaTarget.insertAdjacentHTML('beforeend','<div data-colorscheme-target="displayMonochrome" class = "scheme-card"></div>');
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
      const colorPicker = `<input type="color" name="" value="${colorHex}">`;
      this.displayMonochromeTarget.insertAdjacentHTML('beforeend',colorPicker);
    });
this.displayMonochromeTarget.insertAdjacentHTML('beforeend',schemeButton)
  })

// 3rd color scheme
this.displayAreaTarget.insertAdjacentHTML('beforeend','<div data-colorscheme-target="displayMonochromeLight" class = "scheme-card"></div>');
this.displayMonochromeLightTarget.insertAdjacentHTML('beforeend',"<p>3nd Suggested Color Scheme</p>");
  fetch(`https://www.thecolorapi.com/scheme?hex=${usercolor}&format=json&mode=monochrome-light&count=5`)
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
      const colorPicker = `<input type="color" name="" value="${colorHex}">`;
      this.displayMonochromeLightTarget.insertAdjacentHTML('beforeend',colorPicker);
    });
this.displayMonochromeLightTarget.insertAdjacentHTML('beforeend',schemeButton)
  })

  // 4th color scheme
this.displayAreaTarget.insertAdjacentHTML('beforeend','<div data-colorscheme-target="displayQuad" class = "scheme-card"></div>');
this.displayQuadTarget.insertAdjacentHTML('beforeend',"<p>3nd Suggested Color Scheme</p>");
  fetch(`https://www.thecolorapi.com/scheme?hex=${usercolor}&format=json&mode=quad&count=5`)
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
      const colorPicker = `<input type="color" name="" value="${colorHex}">`;
      this.displayQuadTarget.insertAdjacentHTML('beforeend',colorPicker);
    });
this.displayQuadTarget.insertAdjacentHTML('beforeend',schemeButton)
  })

  }
}
