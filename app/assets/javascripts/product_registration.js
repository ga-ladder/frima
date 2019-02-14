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
        var responseData = $(data).filter(".modal");
        var okOrNot = responseData.length === 1;
        if (okOrNot){
          $("#complete").append(responseData).hide().fadeIn(300);
        } else {
          $("#new_product")[0].submit();
        }
      })
      .fail(function(e){
        console.log("error")
      })
    })
  }
})
