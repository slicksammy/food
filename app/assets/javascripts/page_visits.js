var href = window.location.href

$.ajax({
  method: 'POST',
  url: '/record_page_visit',
  data: { url: href }
});
