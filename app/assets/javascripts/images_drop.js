$(function(){
  /* ドラッグ&ドロップで画像投稿 */
  var dropbox;
  /*イベントハンドラを止める1*/
  dropbox = document.getElementById("dropbox");
  dropbox.addEventListener("dragenter", dragenter, false);
  dropbox.addEventListener("dragover", dragover, false);
  dropbox.addEventListener("drop", drop, false);
  /* イベントハンドラを止める method1 */
  function dragenter(e) {
    e.stopPropagation();
    e.preventDefault();
    len = $("#dropbox")[0].children.length;
    console.log(len)
    if (len < 1){
      element = document.createElement('p')
      element.textContent = "ここにいれてね"
      element
      document.getElementById("dropbox").appendChild(element);
    }
  }

  /* イベントハンドラを止めるmethod2 */
  function dragover(e) {
    e.stopPropagation();
    e.preventDefault();
  }
  /* イベントハンドラを止めるmethod2 */

  function drop(e) {
    e.stopPropagation();
    e.preventDefault();

    var dt = e.dataTransfer;
    var files = dt.files;

    handleFile(files);
  }

  function imgHTML(url){
    var edit =`
      <label for="product" id="dropbox">
        編集
        <input type="file" class="hidden" id="product">
      </label>`
    var html =`
          <div id="" class="drop__dropped">
            <img src=${ url } class="drop__image">
            <ul class="drop__list">
              <li>${ edit }</li>
              <li><button id="imageDelete">削除</button></li>
            </ul>
          </div>
          <input type:file value img>
          `
    return html
  }

  /* 複数のファイルオブジェクトをもらって画像を表示させる */
  function handleFile(fileList) {
    console.log(fileList);

    /* ファイルリストを処理するコードがここに入る */
    var objectURL = window.URL.createObjectURL(fileList[0]);

    var imgField = document.getElementById("drop");
    imgField.insertAdjacentHTML('afterbegin',imgHTML(objectURL));
  }




$('#myImage').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $("#preview").attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
});












})

