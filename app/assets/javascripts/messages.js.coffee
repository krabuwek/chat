$('.messages').ready ->
  App.messages = App.cable.subscriptions.create { channel: 'MessagesChannel', id: Number(document.URL.match(/\/\d+\//)[0].match(/\d+/))},
    received: (data) -> 
      $('#messages').append("<div class=\"message\" id=\"#{data.id}\"><p>#{data.message}</p><p>#{data.username}</p></div>")
      $('#messages').scrollTop($('#messages')[0].scrollHeight)
    

$(document).ready ->
  $('#messages').scrollTop($('#messages')[0].scrollHeight)
  url = $("nav.pagination a[rel=next]").attr("href");
  console.log(url)
  $("#messages").scroll (event)->
    if event.target.scrollTop == 0 and url != null
      height = 0
      $.get
        url: url
        success: (data) ->
          url = data.paginate.next.href
          for message in data.messages
            $('#messages').prepend("<div class=\"message\" id=\"#{message.id}\"><p>#{message.text}</p><p>#{message.author}</p></div>")
            height += $('#messages :first').outerHeight(true)
          console.log(height)
          $("#messages").scrollTop(height)
        dataType: 'json' 
