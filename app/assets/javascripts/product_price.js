$(function(){
  if(window.location.href.indexOf("products") > -1){
    if ($("#product_price").val() != "") {
      var price = $("#product_price").val();
      var commission = Math.ceil(price / 10);
      $(".form__price__commission")[0].innerText = commission;
      $(".form__price__commission")[1].innerText = price - commission;
    }
    var inputPrice = $("#product_price");
    inputPrice.on("keyup", function(){
      var commission = Math.ceil($(this).val() / 10);
      $(".form__price__commission")[0].innerText = commission;
      $(".form__price__commission")[1].innerText = $(this).val() - commission;
    });
  }
})
