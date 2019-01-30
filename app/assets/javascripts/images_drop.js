/* drag & drop イベントを止める */
function dragenter(e) {
  e.stopPropagation();
  e.preventDefault();
}

function dragover(e) {
  e.stopPropagation();
  e.preventDefault();
}

function drop(e) {
  e.stopPropagation();
  e.preventDefault();
  var dt = e.dataTransfer;
  var files = dt.files

  if (limitImages(fileCollection,files)){
    if (allImages(files)){
      inputFiles[0].files = files;
    } else {
      alert("画像ファイル以外のファイルが含まれています")
    }
  } else {
    alert("合計ファイルが４つ以上になってしまいます")
  }
}
/* ------------------------------------------- */

function createImage(blob) {
  var blobURL = URL.createObjectURL(blob),
  image = $("<img>", {
    class:'drop__image',
    name: blob.name,
    src:blobURL
  })[0];

  return image;
}

function imgComponent(image){
  var droppedComponent = $("<div>", { class:'drop__dropped' })[0];
  var ul = "<ul class=\"drop__list\">";
  ul += "<li><label for=\"product_images\" id=\"editImg\">編集</label></li>";
  ul += "<li><label id=\"deleteImg\">削除</label></li>";
  ul += "</ul>";

  droppedComponent.appendChild(image);
  droppedComponent.innerHTML += ul;

  return droppedComponent;
}

/* -------------------------------------------------- */

function manageFileList(listFiles, collection){
  for (var i = 0; i < listFiles.length; i++) {
    collection.push(listFiles[i])
  }
  return collection;
}

function handleFile(fileList, imgField) {
  /* ファイルリストを処理するコードがここに入る */
  /* 複数のファイルオブジェクトをもらう(fileList) */
  for (var i = 0; i < fileList.length; i++) {
    var file = fileList[i];
    var objectURL = window.URL.createObjectURL(file);
    var image = createImage(file);
    var outputImg = imgComponent(image);
    /* 画像を1つ表示させる */
    imgField.insertBefore(outputImg, dropbox);
  }
}

/* -------------------------------------------------- */
// 追加した画像を削除

function elementDelete(element){
  var deleteElement = element.parents('.drop__dropped');
  fileName = deleteElement[0].firstElementChild.name
  fileCollection.some(function(file, i){
    if (file.name===fileName) fileCollection.splice(i,1);
  });
  deleteElement.remove();
}

/* -------------------------------------------------- */
// 画像ファイルかどうか
function allImages(files){
  for (var i = 0; i < files.length; i++) {
    var mockImage = files[i].type.indexOf("image")
    if (mockImage !== 0) return false
  }
  return true
}

function limitImages(fileCollection, files){
  var lengthOfList = fileCollection.length + files.length;
  return ( lengthOfList <= 4 )
}
/* -------------------------------------------------- */
// main
$(function(){
  if(window.location.href.indexOf("products") > -1){
    var imgField = document.getElementById("drop");
    var clickLabel = "";

    /* ドラッグ&ドロップで画像表示 */
    var dropbox;
    /*イベントを止める*/
    dropbox = $("#dropbox")[0];
    dropbox.addEventListener("dragenter", dragenter, false);
    dropbox.addEventListener("dragover", dragover, false);
    dropbox.addEventListener("drop", drop, false);

    fileCollection = [];
    inputFiles = $('#product_images');
    var fileList = inputFiles[0].files;

    inputFiles.off('change')
    inputFiles.on('change', function (e) {
      $(".drop__dropped").remove()
      fileList = $(this)[0].files
    /* -------------------------------------------------- */
    // キャンセルボタンを押しているかどうか(通常時/編集時)
      if (!fileList.length){
        e.stopPropagation()
      }else if (clickLabel === "editImg"){
        elementDelete(clickImage);
      }
      clickLabel = "";
    /* -------------------------------------------------- */
    // 追加された画像をarrayに入れて表示（複数）
      fileCollection = manageFileList(fileList,fileCollection);
      handleFile(fileCollection, imgField);
    });

  /* -------------------------------------------------- */
  // 削除 編集 機能
    $("#drop").on('click',".drop__dropped ul [id=deleteImg]",function(){
      elementDelete($(this));
    })
    $("#drop").on('click',".drop__dropped ul [id=editImg]",function(){
      // elementDelete($(this));
      clickLabel = "editImg";
      clickImage = $(this)
    })
  }
})
