window.onload = function(){
  $('.slickImages').slick({
    asNavFor: '.item-content__images ul',
    arrows: false
  });
  $('.item-content__images ul').slick({
      slidesToShow: 4,
      asNavFor: '.slickImages',
      focusOnSelect: true,
      arrows: false,
      swipe: false,
      unslick: true
  });
    $('.item-content__images ul li').on('mouseover', function() {
        $('.slickImages').slick('goTo', $(this).index());
    });
}
