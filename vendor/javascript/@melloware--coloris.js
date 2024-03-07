const e=(()=>((e,t,l,r)=>{const a=t.createElement("canvas").getContext("2d");const o={r:0,g:0,b:0,h:0,s:0,v:0,a:1};let n,s,i,c,d,u,p,f,h,b,g,m,y,v,k,w,L={};const E={el:"[data-coloris]",parent:"body",theme:"default",themeMode:"light",rtl:false,wrap:true,margin:2,format:"hex",formatToggle:false,swatches:[],swatchesOnly:false,alpha:true,forceAlpha:false,focusInput:true,selectInput:false,inline:false,defaultColor:"#000000",clearButton:false,clearLabel:"Clear",closeButton:false,closeLabel:"Close",onChange:()=>r,a11y:{open:"Open color picker",close:"Close color picker",clear:"Clear the selected color",marker:"Saturation: {s}. Brightness: {v}.",hueSlider:"Hue slider",alphaSlider:"Opacity slider",input:"Color value field",format:"Color format",swatch:"Color swatch",instruction:"Saturation and brightness selector. Use up, down, left and right arrow keys to select."}};const A={};let C="";let S={};let x=false;
/**
     * Configure the color picker.
     * @param {object} options Configuration options.
     */function configure(l){if(typeof l==="object")for(const a in l)switch(a){case"el":bindFields(l.el);l.wrap!==false&&wrapFields(l.el);break;case"parent":n=t.querySelector(l.parent);if(n){n.appendChild(s);E.parent=l.parent;n===t.body&&(n=r)}break;case"themeMode":E.themeMode=l.themeMode;l.themeMode==="auto"&&e.matchMedia&&e.matchMedia("(prefers-color-scheme: dark)").matches&&(E.themeMode="dark");case"theme":l.theme&&(E.theme=l.theme);s.className=`clr-picker clr-${E.theme} clr-${E.themeMode}`;E.inline&&updatePickerPosition();break;case"rtl":E.rtl=!!l.rtl;t.querySelectorAll(".clr-field").forEach((e=>e.classList.toggle("clr-rtl",E.rtl)));break;case"margin":l.margin*=1;E.margin=isNaN(l.margin)?E.margin:l.margin;break;case"wrap":l.el&&l.wrap&&wrapFields(l.el);break;case"formatToggle":E.formatToggle=!!l.formatToggle;getEl("clr-format").style.display=E.formatToggle?"block":"none";E.formatToggle&&(E.format="auto");break;case"swatches":if(Array.isArray(l.swatches)){const e=[];l.swatches.forEach(((t,l)=>{e.push(`<button type="button" id="clr-swatch-${l}" aria-labelledby="clr-swatch-label clr-swatch-${l}" style="color: ${t};">${t}</button>`)}));getEl("clr-swatches").innerHTML=e.length?`<div>${e.join("")}</div>`:"";E.swatches=l.swatches.slice()}break;case"swatchesOnly":E.swatchesOnly=!!l.swatchesOnly;s.setAttribute("data-minimal",E.swatchesOnly);break;case"alpha":E.alpha=!!l.alpha;s.setAttribute("data-alpha",E.alpha);break;case"inline":E.inline=!!l.inline;s.setAttribute("data-inline",E.inline);if(E.inline){const e=l.defaultColor||E.defaultColor;v=getColorFormatFromStr(e);updatePickerPosition();setColorFromStr(e)}break;case"clearButton":if(typeof l.clearButton==="object"){if(l.clearButton.label){E.clearLabel=l.clearButton.label;p.innerHTML=E.clearLabel}l.clearButton=l.clearButton.show}E.clearButton=!!l.clearButton;p.style.display=E.clearButton?"block":"none";break;case"clearLabel":E.clearLabel=l.clearLabel;p.innerHTML=E.clearLabel;break;case"closeButton":E.closeButton=!!l.closeButton;E.closeButton?s.insertBefore(f,d):d.appendChild(f);break;case"closeLabel":E.closeLabel=l.closeLabel;f.innerHTML=E.closeLabel;break;case"a11y":const o=l.a11y;let c=false;if(typeof o==="object")for(const e in o)if(o[e]&&E.a11y[e]){E.a11y[e]=o[e];c=true}if(c){const e=getEl("clr-open-label");const t=getEl("clr-swatch-label");e.innerHTML=E.a11y.open;t.innerHTML=E.a11y.swatch;f.setAttribute("aria-label",E.a11y.close);p.setAttribute("aria-label",E.a11y.clear);h.setAttribute("aria-label",E.a11y.hueSlider);g.setAttribute("aria-label",E.a11y.alphaSlider);u.setAttribute("aria-label",E.a11y.input);i.setAttribute("aria-label",E.a11y.instruction)}break;default:E[a]=l[a]}}
/**
     * Add or update a virtual instance.
     * @param {String} selector The CSS selector of the elements to which the instance is attached.
     * @param {Object} options Per-instance options to apply.
     */function setVirtualInstance(e,t){if(typeof e==="string"&&typeof t==="object"){A[e]=t;x=true}}
/**
     * Remove a virtual instance.
     * @param {String} selector The CSS selector of the elements to which the instance is attached.
     */function removeVirtualInstance(e){delete A[e];if(Object.keys(A).length===0){x=false;e===C&&resetVirtualInstance()}}
/**
     * Attach a virtual instance to an element if it matches a selector.
     * @param {Object} element Target element that will receive a virtual instance if applicable.
     */function attachVirtualInstance(e){if(x){const t=["el","wrap","rtl","inline","defaultColor","a11y"];for(let l in A){const r=A[l];if(e.matches(l)){C=l;S={};t.forEach((e=>delete r[e]));for(let e in r)S[e]=Array.isArray(E[e])?E[e].slice():E[e];configure(r);break}}}}function resetVirtualInstance(){if(Object.keys(S).length>0){configure(S);C="";S={}}}
/**
     * Bind the color picker to input fields that match the selector.
     * @param {string} selector One or more selectors pointing to input fields.
     */function bindFields(e){addListener(t,"click",e,(e=>{if(!E.inline){attachVirtualInstance(e.target);y=e.target;k=y.value;v=getColorFormatFromStr(k);s.classList.add("clr-open");updatePickerPosition();setColorFromStr(k);if(E.focusInput||E.selectInput){u.focus({preventScroll:true});u.setSelectionRange(y.selectionStart,y.selectionEnd)}E.selectInput&&u.select();(w||E.swatchesOnly)&&getFocusableElements().shift().focus();y.dispatchEvent(new Event("open",{bubbles:true}))}}));addListener(t,"input",e,(e=>{const t=e.target.parentNode;t.classList.contains("clr-field")&&(t.style.color=e.target.value)}))}function updatePickerPosition(){if(!s||!y&&!E.inline)return;const l=n;const r=e.scrollY;const a=s.offsetWidth;const o=s.offsetHeight;const c={left:false,top:false};let d,u,p;let f={x:0,y:0};if(l){d=e.getComputedStyle(l);u=parseFloat(d.marginTop);p=parseFloat(d.borderTopWidth);f=l.getBoundingClientRect();f.y+=p+r}if(!E.inline){const e=y.getBoundingClientRect();let n=e.x;let i=r+e.y+e.height+E.margin;if(l){n-=f.x;i-=f.y;if(n+a>l.clientWidth){n+=e.width-a;c.left=true}if(i+o>l.clientHeight-u&&o+E.margin<=e.top-(f.y-r)){i-=e.height+o+E.margin*2;c.top=true}i+=l.scrollTop}else{if(n+a>t.documentElement.clientWidth){n+=e.width-a;c.left=true}if(i+o-r>t.documentElement.clientHeight&&o+E.margin<=e.top){i=r+e.y-o-E.margin;c.top=true}}s.classList.toggle("clr-left",c.left);s.classList.toggle("clr-top",c.top);s.style.left=`${n}px`;s.style.top=`${i}px`;f.x+=s.offsetLeft;f.y+=s.offsetTop}L={width:i.offsetWidth,height:i.offsetHeight,x:i.offsetLeft+f.x,y:i.offsetTop+f.y}}
/**
     * Wrap the linked input fields in a div that adds a color preview.
     * @param {string} selector One or more selectors pointing to input fields.
     */function wrapFields(e){t.querySelectorAll(e).forEach((e=>{const l=e.parentNode;if(!l.classList.contains("clr-field")){const r=t.createElement("div");let a="clr-field";(E.rtl||e.classList.contains("clr-rtl"))&&(a+=" clr-rtl");r.innerHTML='<button type="button" aria-labelledby="clr-open-label"></button>';l.insertBefore(r,e);r.setAttribute("class",a);r.style.color=e.value;r.appendChild(e)}}))}
/**
     * Close the color picker.
     * @param {boolean} [revert] If true, revert the color to the original value.
     */function closePicker(e){if(y&&!E.inline){const t=y;if(e){y=r;if(k!==t.value){t.value=k;t.dispatchEvent(new Event("input",{bubbles:true}))}}setTimeout((()=>{k!==t.value&&t.dispatchEvent(new Event("change",{bubbles:true}))}));s.classList.remove("clr-open");x&&resetVirtualInstance();t.dispatchEvent(new Event("close",{bubbles:true}));E.focusInput&&t.focus({preventScroll:true});y=r}}
/**
     * Set the active color from a string.
     * @param {string} str String representing a color.
     */function setColorFromStr(e){const t=strToRGBA(e);const l=RGBAtoHSVA(t);updateMarkerA11yLabel(l.s,l.v);updateColor(t,l);h.value=l.h;s.style.color=`hsl(${l.h}, 100%, 50%)`;b.style.left=l.h/360*100+"%";c.style.left=L.width*l.s/100+"px";c.style.top=L.height-L.height*l.v/100+"px";g.value=l.a*100;m.style.left=l.a*100+"%"}
/**
     * Guess the color format from a string.
     * @param {string} str String representing a color.
     * @return {string} The color format.
     */function getColorFormatFromStr(e){const t=e.substring(0,3).toLowerCase();return t==="rgb"||t==="hsl"?t:"hex"}
/**
     * Copy the active color to the linked input field.
     * @param {number} [color] Color value to override the active color.
     */function pickColor(l){l=l!==r?l:u.value;if(y){y.value=l;y.dispatchEvent(new Event("input",{bubbles:true}))}E.onChange&&E.onChange.call(e,l,y);t.dispatchEvent(new CustomEvent("coloris:pick",{detail:{color:l,currentEl:y}}))}
/**
     * Set the active color based on a specific point in the color gradient.
     * @param {number} x Left position.
     * @param {number} y Top position.
     */function setColorAtPosition(e,t){const l={h:h.value*1,s:e/L.width*100,v:100-t/L.height*100,a:g.value/100};const r=HSVAtoRGBA(l);updateMarkerA11yLabel(l.s,l.v);updateColor(r,l);pickColor()}
/**
     * Update the color marker's accessibility label.
     * @param {number} saturation
     * @param {number} value
     */function updateMarkerA11yLabel(e,t){let l=E.a11y.marker;e=e.toFixed(1)*1;t=t.toFixed(1)*1;l=l.replace("{s}",e);l=l.replace("{v}",t);c.setAttribute("aria-label",l)}
/**
     * Get the pageX and pageY positions of the pointer.
     * @param {object} event The MouseEvent or TouchEvent object.
     * @return {object} The pageX and pageY positions.
     */function getPointerPosition(e){return{pageX:e.changedTouches?e.changedTouches[0].pageX:e.pageX,pageY:e.changedTouches?e.changedTouches[0].pageY:e.pageY}}
/**
     * Move the color marker when dragged.
     * @param {object} event The MouseEvent object.
     */function moveMarker(e){const t=getPointerPosition(e);let l=t.pageX-L.x;let r=t.pageY-L.y;n&&(r+=n.scrollTop);setMarkerPosition(l,r);e.preventDefault();e.stopPropagation()}
/**
     * Move the color marker when the arrow keys are pressed.
     * @param {number} offsetX The horizontal amount to move.
     * @param {number} offsetY The vertical amount to move.
     */function moveMarkerOnKeydown(e,t){let l=c.style.left.replace("px","")*1+e;let r=c.style.top.replace("px","")*1+t;setMarkerPosition(l,r)}
/**
     * Set the color marker's position.
     * @param {number} x Left position.
     * @param {number} y Top position.
     */function setMarkerPosition(e,t){e=e<0?0:e>L.width?L.width:e;t=t<0?0:t>L.height?L.height:t;c.style.left=`${e}px`;c.style.top=`${t}px`;setColorAtPosition(e,t);c.focus()}
/**
     * Update the color picker's input field and preview thumb.
     * @param {Object} rgba Red, green, blue and alpha values.
     * @param {Object} [hsva] Hue, saturation, value and alpha values.
     */function updateColor(e,l){e===void 0&&(e={});l===void 0&&(l={});let r=E.format;for(const t in e)o[t]=e[t];for(const e in l)o[e]=l[e];const a=RGBAToHex(o);const n=a.substring(0,7);c.style.color=n;m.parentNode.style.color=n;m.style.color=a;d.style.color=a;i.style.display="none";i.offsetHeight;i.style.display="";m.nextElementSibling.style.display="none";m.nextElementSibling.offsetHeight;m.nextElementSibling.style.display="";r==="mixed"?r=o.a===1?"hex":"rgb":r==="auto"&&(r=v);switch(r){case"hex":u.value=a;break;case"rgb":u.value=RGBAToStr(o);break;case"hsl":u.value=HSLAToStr(HSVAtoHSLA(o));break}t.querySelector(`.clr-format [value="${r}"]`).checked=true}function setHue(){const e=h.value*1;const t=c.style.left.replace("px","")*1;const l=c.style.top.replace("px","")*1;s.style.color=`hsl(${e}, 100%, 50%)`;b.style.left=e/360*100+"%";setColorAtPosition(t,l)}function setAlpha(){const e=g.value/100;m.style.left=e*100+"%";updateColor({a:e});pickColor()}
/**
     * Convert HSVA to RGBA.
     * @param {object} hsva Hue, saturation, value and alpha values.
     * @return {object} Red, green, blue and alpha values.
     */function HSVAtoRGBA(e){const t=e.s/100;const r=e.v/100;let a=t*r;let o=e.h/60;let n=a*(1-l.abs(o%2-1));let s=r-a;a+=s;n+=s;const i=l.floor(o)%6;const c=[a,n,s,s,n,a][i];const d=[n,a,a,n,s,s][i];const u=[s,s,n,a,a,n][i];return{r:l.round(c*255),g:l.round(d*255),b:l.round(u*255),a:e.a}}
/**
     * Convert HSVA to HSLA.
     * @param {object} hsva Hue, saturation, value and alpha values.
     * @return {object} Hue, saturation, lightness and alpha values.
     */function HSVAtoHSLA(e){const t=e.v/100;const r=t*(1-e.s/100/2);let a;r>0&&r<1&&(a=l.round((t-r)/l.min(r,1-r)*100));return{h:e.h,s:a||0,l:l.round(r*100),a:e.a}}
/**
     * Convert RGBA to HSVA.
     * @param {object} rgba Red, green, blue and alpha values.
     * @return {object} Hue, saturation, value and alpha values.
     */function RGBAtoHSVA(e){const t=e.r/255;const r=e.g/255;const a=e.b/255;const o=l.max(t,r,a);const n=l.min(t,r,a);const s=o-n;const i=o;let c=0;let d=0;if(s){o===t&&(c=(r-a)/s);o===r&&(c=2+(a-t)/s);o===a&&(c=4+(t-r)/s);o&&(d=s/o)}c=l.floor(c*60);return{h:c<0?c+360:c,s:l.round(d*100),v:l.round(i*100),a:e.a}}
/**
     * Parse a string to RGBA.
     * @param {string} str String representing a color.
     * @return {object} Red, green, blue and alpha values.
     */function strToRGBA(e){const t=/^((rgba)|rgb)[\D]+([\d.]+)[\D]+([\d.]+)[\D]+([\d.]+)[\D]*?([\d.]+|$)/i;let l,r;a.fillStyle="#000";a.fillStyle=e;l=t.exec(a.fillStyle);if(l)r={r:l[3]*1,g:l[4]*1,b:l[5]*1,a:l[6]*1};else{l=a.fillStyle.replace("#","").match(/.{2}/g).map((e=>parseInt(e,16)));r={r:l[0],g:l[1],b:l[2],a:1}}return r}
/**
     * Convert RGBA to Hex.
     * @param {object} rgba Red, green, blue and alpha values.
     * @return {string} Hex color string.
     */function RGBAToHex(e){let t=e.r.toString(16);let l=e.g.toString(16);let r=e.b.toString(16);let a="";e.r<16&&(t="0"+t);e.g<16&&(l="0"+l);e.b<16&&(r="0"+r);if(E.alpha&&(e.a<1||E.forceAlpha)){const t=e.a*255|0;a=t.toString(16);t<16&&(a="0"+a)}return"#"+t+l+r+a}
/**
     * Convert RGBA values to a CSS rgb/rgba string.
     * @param {object} rgba Red, green, blue and alpha values.
     * @return {string} CSS color string.
     */function RGBAToStr(e){return!E.alpha||e.a===1&&!E.forceAlpha?`rgb(${e.r}, ${e.g}, ${e.b})`:`rgba(${e.r}, ${e.g}, ${e.b}, ${e.a})`}
/**
     * Convert HSLA values to a CSS hsl/hsla string.
     * @param {object} hsla Hue, saturation, lightness and alpha values.
     * @return {string} CSS color string.
     */function HSLAToStr(e){return!E.alpha||e.a===1&&!E.forceAlpha?`hsl(${e.h}, ${e.s}%, ${e.l}%)`:`hsla(${e.h}, ${e.s}%, ${e.l}%, ${e.a})`}function init(){if(!t.getElementById("clr-picker")){n=r;s=t.createElement("div");s.setAttribute("id","clr-picker");s.className="clr-picker";s.innerHTML=`<input id="clr-color-value" name="clr-color-value" class="clr-color" type="text" value="" spellcheck="false" aria-label="${E.a11y.input}"><div id="clr-color-area" class="clr-gradient" role="application" aria-label="${E.a11y.instruction}"><div id="clr-color-marker" class="clr-marker" tabindex="0"></div></div><div class="clr-hue"><input id="clr-hue-slider" name="clr-hue-slider" type="range" min="0" max="360" step="1" aria-label="${E.a11y.hueSlider}"><div id="clr-hue-marker"></div></div><div class="clr-alpha"><input id="clr-alpha-slider" name="clr-alpha-slider" type="range" min="0" max="100" step="1" aria-label="${E.a11y.alphaSlider}"><div id="clr-alpha-marker"></div><span></span></div><div id="clr-format" class="clr-format"><fieldset class="clr-segmented"><legend>${E.a11y.format}</legend><input id="clr-f1" type="radio" name="clr-format" value="hex"><label for="clr-f1">Hex</label><input id="clr-f2" type="radio" name="clr-format" value="rgb"><label for="clr-f2">RGB</label><input id="clr-f3" type="radio" name="clr-format" value="hsl"><label for="clr-f3">HSL</label><span></span></fieldset></div><div id="clr-swatches" class="clr-swatches"></div><button type="button" id="clr-clear" class="clr-clear" aria-label="${E.a11y.clear}">${E.clearLabel}</button><div id="clr-color-preview" class="clr-preview"><button type="button" id="clr-close" class="clr-close" aria-label="${E.a11y.close}">${E.closeLabel}</button></div><span id="clr-open-label" hidden>${E.a11y.open}</span><span id="clr-swatch-label" hidden>${E.a11y.swatch}</span>`;t.body.appendChild(s);i=getEl("clr-color-area");c=getEl("clr-color-marker");p=getEl("clr-clear");f=getEl("clr-close");d=getEl("clr-color-preview");u=getEl("clr-color-value");h=getEl("clr-hue-slider");b=getEl("clr-hue-marker");g=getEl("clr-alpha-slider");m=getEl("clr-alpha-marker");bindFields(E.el);wrapFields(E.el);addListener(s,"mousedown",(e=>{s.classList.remove("clr-keyboard-nav");e.stopPropagation()}));addListener(i,"mousedown",(e=>{addListener(t,"mousemove",moveMarker)}));addListener(i,"touchstart",(e=>{t.addEventListener("touchmove",moveMarker,{passive:false})}));addListener(c,"mousedown",(e=>{addListener(t,"mousemove",moveMarker)}));addListener(c,"touchstart",(e=>{t.addEventListener("touchmove",moveMarker,{passive:false})}));addListener(u,"change",(e=>{const t=u.value;if(y||E.inline){const e=t===""?t:setColorFromStr(t);pickColor(e)}}));addListener(p,"click",(e=>{pickColor("");closePicker()}));addListener(f,"click",(e=>{pickColor();closePicker()}));addListener(getEl("clr-format"),"click",".clr-format input",(e=>{v=e.target.value;updateColor();pickColor()}));addListener(s,"click",".clr-swatches button",(e=>{setColorFromStr(e.target.textContent);pickColor();E.swatchesOnly&&closePicker()}));addListener(t,"mouseup",(e=>{t.removeEventListener("mousemove",moveMarker)}));addListener(t,"touchend",(e=>{t.removeEventListener("touchmove",moveMarker)}));addListener(t,"mousedown",(e=>{w=false;s.classList.remove("clr-keyboard-nav");closePicker()}));addListener(t,"keydown",(e=>{const t=e.key;const l=e.target;const r=e.shiftKey;const a=["Tab","ArrowUp","ArrowDown","ArrowLeft","ArrowRight"];if(t==="Escape")closePicker(true);else if(a.includes(t)){w=true;s.classList.add("clr-keyboard-nav")}if(t==="Tab"&&l.matches(".clr-picker *")){const t=getFocusableElements();const a=t.shift();const o=t.pop();if(r&&l===a){o.focus();e.preventDefault()}else if(!r&&l===o){a.focus();e.preventDefault()}}}));addListener(t,"click",".clr-field button",(e=>{x&&resetVirtualInstance();e.target.nextElementSibling.dispatchEvent(new Event("click",{bubbles:true}))}));addListener(c,"keydown",(e=>{const t={ArrowUp:[0,-1],ArrowDown:[0,1],ArrowLeft:[-1,0],ArrowRight:[1,0]};if(Object.keys(t).includes(e.key)){moveMarkerOnKeydown(...t[e.key]);e.preventDefault()}}));addListener(i,"click",moveMarker);addListener(h,"input",setHue);addListener(g,"input",setAlpha)}}function getFocusableElements(){const e=Array.from(s.querySelectorAll("input, button"));const t=e.filter((e=>!!e.offsetWidth));return t}
/**
     * Shortcut for getElementById to optimize the minified JS.
     * @param {string} id The element id.
     * @return {object} The DOM element with the provided id.
     */function getEl(e){return t.getElementById(e)}
/**
     * Shortcut for addEventListener to optimize the minified JS.
     * @param {object} context The context to which the listener is attached.
     * @param {string} type Event type.
     * @param {(string|function)} selector Event target if delegation is used, event handler if not.
     * @param {function} [fn] Event handler if delegation is used.
     */function addListener(e,t,l,r){const a=Element.prototype.matches||Element.prototype.msMatchesSelector;if(typeof l==="string")e.addEventListener(t,(e=>{a.call(e.target,l)&&r.call(e.target,e)}));else{r=l;e.addEventListener(t,r)}}
/**
     * Call a function only when the DOM is ready.
     * @param {function} fn The function to call.
     * @param {array} [args] Arguments to pass to the function.
     */function DOMReady(e,l){l=l!==r?l:[];t.readyState!=="loading"?e(...l):t.addEventListener("DOMContentLoaded",(()=>{e(...l)}))}NodeList!==r&&NodeList.prototype&&!NodeList.prototype.forEach&&(NodeList.prototype.forEach=Array.prototype.forEach);
/**
     * Copy the active color to the linked input field and set the color.
     * @param {string} [color] Color value to override the active color.
     * @param {HTMLelement} [target] the element setting the color on
     */function setColor(e,t){y=t;k=y.value;attachVirtualInstance(t);v=getColorFormatFromStr(e);updatePickerPosition();setColorFromStr(e);pickColor();k!==e&&y.dispatchEvent(new Event("change",{bubbles:true}))}const M=(()=>{const t={init:init,set:configure,wrap:wrapFields,close:closePicker,setInstance:setVirtualInstance,setColor:setColor,removeInstance:removeVirtualInstance,updatePosition:updatePickerPosition,ready:DOMReady};function Coloris(e){DOMReady((()=>{e&&(typeof e==="string"?bindFields(e):configure(e))}))}for(const e in t)Coloris[e]=function(){for(var l=arguments.length,r=new Array(l),a=0;a<l;a++)r[a]=arguments[a];DOMReady(t[e],r)};DOMReady((()=>{e.addEventListener("resize",(e=>{Coloris.updatePosition()}));e.addEventListener("scroll",(e=>{Coloris.updatePosition()}))}));return Coloris})();M.coloris=M;return M})(window,document,Math))();const t=e.coloris;const l=e.init;const r=e.set;const a=e.wrap;const o=e.close;const n=e.setInstance;const s=e.removeInstance;const i=e.updatePosition;export{o as close,t as coloris,e as default,l as init,s as removeInstance,r as set,n as setInstance,i as updatePosition,a as wrap};

