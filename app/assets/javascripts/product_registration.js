$(function(){
  if(window.location.href.indexOf("products") > -1){

    $("#new_product").on('submit',function(e){
      e.preventDefault();

    /* -------------------------------------------------- */
    // paramsの編集
      formData = new FormData($(this).get(0));
      formData.delete("product[images][]")
      for(item of fileCollection) formData.append("product[images][]",item);

    // create action
      var url = $('#new_product').attr('action');

      $.ajax({
        url: url,
        type: "POST",
        processData: false,
        contentType: false,
        data: formData,
        dataType:'html'
      })
      .done(function(data){
        d = data;
        console.log(d)
        var okOrNot = renderData(data).className === "modal";
        if (okOrNot){
          $("#complete").append(data).hide().fadeIn(300);
        } else {
          $("#new_product")[0].submit();
        }
      })
      .fail(function(e){
        console.log(e)
      })
    })
  }
})
