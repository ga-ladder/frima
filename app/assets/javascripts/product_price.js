$(function(){
  if(window.location.href.indexOf("products") > -1){

    var inputPrice = $("#product_price");
    inputPrice.on("change", function(){
      var price = inputPrice.val();
      var commission = Math.ceil(price / 10);
      $(".form__price__commission")[0].innerText = commission;
      $(".form__price__commission")[1].innerText = price - commission;
    })

  }
})
