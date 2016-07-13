$('.messages').ready ->
  App.messages = App.cable.subscriptions.create { channel: 'MessagesChannel', id: Number(document.URL.match(/\/\d+\//)[0].match(/\d+/))},
    received: (data) ->
      $('.messages').append('<p><b>'+ data.username + ':</b>' + data.message + '</p>');

$(document).ready ->
  $("#messages .page").infinitescroll 
    navSelector: "nav.pagination"
    nextSelector: "nav.pagination a[rel=next]" 
    itemSelector: "#messages tr.message" 
$(window).scroll()