var windows = []

$('.biz-name.js-analytics-click').each(function(index, element) {
    windows.push(window.open(element.href)); })

// var urls = []

windows.forEach( function(window, index) {
  windows[index].focus()

  window.addEventListener("DOMContentLoaded", function(){

    // window.location = 'https://www.google.com'
    var d = window.document
    var elements = []
    
    if (d) { elements = d.getElementsByClassName('biz-website js-add-url-tagging'); }

    if (elements && elements[0]) {
      window.location = "http://www." + elements[0].childNodes[3].innerText;
    };
  }.bind(this))
}.bind(this))



$('input#field-name').val('sam');
$('input#field-email').val('sam@iheartmeat.com');
$('input#field-phone').val('3125237986')
$('#field-message').val("Hi, \n\nWe invite you to check out www.iheartmeat.com. iheartmeat delivers premium steaks next day at prices you can't beat. If you don't like our product for any reason you get a full refund. What can be better than the gift of delicious steak? Check us out www.iheartmeat.com. \n\nSam")
