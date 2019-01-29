/* ------------------------------------------- */
// main
$(document).on('turbolinks:load',function(){
  if(window.location.href.indexOf("products/new") > -1){

    function nextCategory(categoryId){
      var next =
      $.ajax({
        url: "/categories/search",
        type: "GET",
        data: { id: categoryId }
      })
      return next
    }

  /* ------------------------------------------- */
    var selectData;
    $("#root_category").on("change", function(){
    // middle / subcategory の除去
      $("#middle_category").remove();
      $("#product_category_id").remove();

      var categoryId = $(this)[0].value;
      nextCategory(categoryId).done(function(data){
      // middle category の追加
        selectData = $(data)[47];
        $(selectData).attr('id','middle_category')
        $(selectData).attr('name','middle[category]')
        $("#category").append(selectData);
        subOnChange();
      })
    })

/* ------------------------------------------- */
  function subOnChange(){
    $("#middle_category").on("change", function(){
      // subcategory の除去
      $("#product_category_id").remove();

      var categoryId = $(this)[0].value;
      nextCategory(categoryId).done(function(data){
      // sub category の追加
        selectData = $(data)[47];
        $("#category").append(selectData);
      })
    })
  }

  }
})
