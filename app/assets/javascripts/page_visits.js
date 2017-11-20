var href = window.location.href;
var referrer = document.referrer;
var defaultTimeout = 5000
var repeats = 0
var pgid;

function updateVisit(repeat, id) {
  $.ajax({
    method: 'POST',
    url: '/update_page_visit',
    data: { pgid: id }
  });

  if (repeat && repeats < 6) {
    setTimeout(function() {updateVisit(true, id)}.bind(this), defaultTimeout)
    repeats++
  }
}

$(document).ready(function() {
  $.ajax({
    method: 'POST',
    url: '/record_page_visit',
    data: { url: href, referrer: referrer },
    success: function(response) {
      pgid = response.pgid
      setTimeout(function() {updateVisit(true, pgid)}.bind(this), defaultTimeout)
    }.bind(this)
  });
});

window.onbeforeunload = function() {
  updateVisit(false, pgid)
};


