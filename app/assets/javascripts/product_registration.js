$(function(){

  $("#new_product").on('submit',function(e){
    e.preventDefault();
    var url = $('#new_product').attr('action');
    $.ajax({
      url: url,
      type: "POST",
    })
    .done(function(data){
      $("#complete").append(data).hide().fadeIn(1000);
    })
  })

})
