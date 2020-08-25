document.addEventListener('turbolinks:load', function () {
  if (document.getElementById('js_img_prev') != null) {
    document.getElementById('user_image').addEventListener('change', function (e) {

      let file = e.target.files[0];
      let fileReader = new FileReader();

      fileReader.onload = function () {
        let dataUri = this.result;
        let img = document.getElementById('js_img_prev');
        img.src = dataUri;
      }

      fileReader.readAsDataURL(file);
    });
  }
});