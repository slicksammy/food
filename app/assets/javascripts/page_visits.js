var href = window.location.href;
var referrer = document.referrer;
var start;

$(document).ready(function() {
  date = new Date()
  start = date.getTime()
});

window.onbeforeunload = function() {
  console.log(start)
  date = new Date()
  end = date.getTime();

  $.ajax({
    method: 'POST',
    url: '/record_page_visit',
    data: { url: href, referrer: referrer, time: end - start }
  });

  console.log('ended')
};


