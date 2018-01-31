$(document).ready(function(){
  $(".cart_update").click(function(){
      setTimeout(function() {tryCheckout()}.bind(this), 500)
  }.bind(this));
}.bind(this));

function tryCheckout() {
  $.ajax({
    method: 'GET',
    url: '/cart/can_checkout',
    success: function(response) {
      if (response.can) {
        $('.checkout').show();
      } else {
        $('.checkout').hide();
      }
    }.bind(this)
  })
}

tryCheckout()
