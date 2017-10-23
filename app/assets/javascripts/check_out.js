$(document).ready(function(){
  $(".cart_update").click(function(){
      setTimeout(function() {tryCheckout()}.bind(this), 500)
  }.bind(this));
}.bind(this));

function tryCheckout() {
  $.ajax({
    method: 'GET',
    url: '/cart/count',
    success: function(response) {
      if (response.count > 0) {
        $('.checkout').show();
      } else {
        $('.checkout').hide();
      }
    }.bind(this)
  })
}

tryCheckout()
