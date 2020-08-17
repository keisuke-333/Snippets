document.addEventListener('turbolinks:load', function () {
  if (document.querySelector(".flash")) {
    const ms = 600;
    const elm = document.querySelector(".flash");
    elm.style.transition = "height " + ms + "ms";
    elm.style.height = "";
    elm.style.overflow = "hidden";
    setTimeout(function () {
      elm.style.height = "0px";
    }, 5000);
    setTimeout(function () {
      elm.parentNode.removeChild(elm);
    }, 6000);
  }
});