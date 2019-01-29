$(document).on('turbolinks:load',function(){
  if(window.location.href.indexOf("products/new") > -1){

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
        $("#complete").append(data).hide().fadeIn(1000);
      })
      .fail(function(e){
        console.log(e)
      })
    })

  }
})
