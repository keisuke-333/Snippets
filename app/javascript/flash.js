document.addEventListener('turbolinks:load', () => {
  if (document.querySelector(".flash") != null) {
    let ms = 600;
    let elm = document.querySelector(".flash");
    elm.style.transition = "height " + ms + "ms";
    elm.style.height = "";
    elm.style.overflow = "hidden";
    setTimeout(() => {
      elm.style.height = "0px";
    }, 5000);
    setTimeout(() => {
      elm.parentNode.removeChild(elm);
    }, 5600);
  }
});