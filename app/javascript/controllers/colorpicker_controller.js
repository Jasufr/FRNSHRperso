import { Controller } from "@hotwired/stimulus"
// import "@melloware/coloris/dist/coloris.css";
import Coloris from "@melloware/coloris";

// Connects to data-controller="colorpicker"
export default class extends Controller {
  connect() {
    Coloris.init();
    Coloris({el: "#colorpicker"});
  }
}
