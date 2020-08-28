document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('js-dropdown-img') != null) {
    let icon = document.getElementById('js-dropdown-img');
    let show = document.getElementById('js-show-list');

    window.addEventListener('click', e => {
      if (e.target == icon) {
        show.classList.toggle('is-open');
      } else {
        show.classList.remove('is-open');
      }
    });

  }
});