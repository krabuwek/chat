$('.messages').ready ->
  App.messages = App.cable.subscriptions.create { channel: 'MessagesChannel', id: Number(document.URL.match(/\/\d+\//)[0].match(/\d+/))},
    received: (data) ->
      if data.user_id == gon.user_id
        $('#messages').append("<div class=\"message sender\" id=\"#{data.id}\"><p>#{data.message}</p><p>#{data.username}</p></div>")
      else
        $('#messages').append("<div class=\"message\" id=\"#{data.id}\"><p>#{data.message}</p><p>#{data.username}</p></div>")
      $('#messages').scrollTop($('#messages')[0].scrollHeight)
    

$(document).ready ->
  $("#new_message").bind("ajax:complete", (event,xhr,status) -> 
    $('#message_text').val('');
  )
  ctrl = false
  $('#message_text').keydown (even) ->
    switch event.which
      when 13 then return false
      when 17 then ctrl = true
  $('#message_text').keyup (event) ->
    switch event.which
      when 13
        if !ctrl  
          $('#new_message').submit()
          return false
        value = $(this).val() + '\n'
        $(this).val(value)
      when 17 then ctrl = false
  $('#messages').scrollTop($('#messages')[0].scrollHeight)
  url = $("nav.pagination a[rel=next]").attr("href");
  user_id = $("#user").attr("user-id")
  $("#messages").scroll (event)->
    if event.target.scrollTop == 0
      height = 0
      $.get
        url: url
        success: (data) ->
          url = data.paginate.next.href
          for message in data.messages
            if message.author_id == gon.user_id
              $('#messages').prepend("<div class=\"message sender\" id=\"#{message.id}\"><p>#{message.text}</p><p>#{message.author}</p></div>")    
            else
              $('#messages').prepend("<div class=\"message\" id=\"#{message.id}\"><p>#{message.text}</p><p>#{message.author}</p></div>")
            height += $('#messages :first').outerHeight(true)
          $("#messages").scrollTop(height)
        dataType: 'json' 
