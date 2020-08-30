document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('js-menu-img') != null) {

    let $imgArea = document.getElementById('js-menu-img');
    let $icon = document.getElementById('js-dropdown-img');
    let $caretDown = document.getElementById('js-caret-down');
    let $showList = document.getElementById('js-show-list');

    window.addEventListener('click', e => {
      if (e.target == $imgArea || e.target == $icon || e.target == $caretDown) {
        $showList.classList.toggle('is-open');
        $caretDown.classList.toggle('caret-down-clicked');
      } else {
        $showList.classList.remove('is-open');
        $caretDown.classList.remove('caret-down-clicked');
      }
    });

  }
});