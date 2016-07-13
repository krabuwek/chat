$('.messages').ready ->
  App.messages = App.cable.subscriptions.create { channel: 'MessagesChannel', id: Number(document.URL.match(/\/\d+\//)[0].match(/\d+/))},
    received: (data) ->
      $('.messages').append('<p><b>'+ data.username + ':</b>' + data.message + '</p>')
