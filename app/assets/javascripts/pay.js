$(function() {
  if(window.location.href.indexOf("customer") > -1){
    Payjp.setPublicKey('pk_test_ec6e9870e838ed6237bf6620');
    var form = $("charge-form"),
        number = $('input[name="number"]')[0],
        cvc = $('input[name="cvc"]')[0],
        exp_month = $('select[name="exp[month]"]')[0],
        exp_year = $('select[name="exp[year]"]')[0];

    $("#charge-form").on('submit', function(e) {
      e.preventDefault();
      form.find("input[type=submit]").prop("disabled", true);

      var card = {
          number: number.value,
          cvc: cvc.value,
          exp_month: exp_month.value,
          exp_year: exp_year.value
      };
      console.log(card)
      Payjp.createToken(card, function(s, response) {
        if (response.error) {
          form.find('.payment-errors').text(response.error.message);
          form.find('button').prop('disabled', false);
        }
        else {
          var token = response.id;
          console.log(token)

          $("#charge-form").append($('<input type="hidden" name="payjpToken" />').val(token));
          $("#charge-form")[0].submit();
        }
      });
    });
  }
});
