var second = function(){
  $('.progress__items').children().filter('.second').addClass('active');
  $('.progress__bar').children().filter('.second').addClass('active');
}
var third = function(){
  $('.progress__items').children().filter('.third').addClass('active');
  $('.progress__bar').children().filter('.third').addClass('active');
}
var fourth = function(){
  $('.progress__items').children().filter('.fourth').addClass('active');
  $('.progress__bar').children().filter('.fourth').addClass('active');
}
var fifth = function(){
  $('.progress__items').children().filter('.fifth').addClass('active');
  $('.progress__bar').children().filter('.fifth').addClass('active');
}
$(function(){
  if(document.URL.match("/phone_registration")){
    second();
  }else if(document.URL.match("/resident_registration")){
    second();
    third();
  }else if(document.URL.match("/customer_registration")){
    second();
    third();
    fourth();
    fifth();
  }
})
