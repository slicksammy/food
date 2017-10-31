var href = window.location.href
var referrer = document.referrer

$.ajax({
  method: 'POST',
  url: '/record_page_visit',
  data: { url: href, referrer: referrer }
});
