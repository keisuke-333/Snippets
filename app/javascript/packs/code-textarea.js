import SimpleMDE from 'simplemde'
document.addEventListener('DOMContentLoaded', () => {
  const simplemde = new SimpleMDE({
    element: document.getElementById("post_code"),
    forceSync: true,
    spellChecker: false
  });
});