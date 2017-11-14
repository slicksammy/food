var href = window.location.href;
var referrer = document.referrer;
var pgid;

$(document).ready(function() {
  $.ajax({
    method: 'POST',
    url: '/record_page_visit',
    data: { url: href, referrer: referrer },
    success: function(response) {
      pgid = response.pgid
    }.bind(this)
  });
});

window.onbeforeunload = function() {
  $.ajax({
    method: 'POST',
    url: '/update_page_visit',
    data: { pgid: pgid }
  });
};


