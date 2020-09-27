document.addEventListener('DOMContentLoaded', () => {
  const tabs = document.getElementsByClassName('link');
  for (let i = 0; i < tabs.length; i++) {
    tabs[i].addEventListener('click', tabSwitch);
  }

  function tabSwitch() {
    document.getElementsByClassName('checked')[0].classList.remove('checked');
    this.classList.add('checked');
  };
});