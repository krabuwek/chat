App.messages = App.cable.subscriptions.create 'MessagesChannel',
  received: (data) ->
    $('.messages').append('<p><b>'+ data.username + ':</b>' + data.message + '</p>')
