import SimpleMDE from 'simplemde'
document.addEventListener('DOMContentLoaded', () => {
  const simplemde = new SimpleMDE({
    element: document.getElementById("post_code"),
    forceSync: true,
    spellChecker: false,
    toolbar: ['bold', 'heading', 'italic', 'code', 'unordered-list', 'ordered-list', '|', 'preview', 'side-by-side', 'fullscreen', '|', 'guide', ]
  });
});