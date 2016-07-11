$(document).ready ->
  App.messages = App.cable.subscriptions.create { channel: 'MessagesChannel', id: $('#message_conference_id').attr('value') },
  received: (data) ->
    $('.messages').append('<p><b>'+ data.username + ':</b>' + data.message + '</p>')