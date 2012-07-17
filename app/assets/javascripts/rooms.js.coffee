//= require jquery-ui

refresh = ->
  $.getJSON('/rooms.json?server_id=' + window.server.id, refresh_do)
refresh_do = (rooms) ->
  $('#rooms').html ''
  $('#users').html ''
  for room in rooms
    room_html = $('<div />',
      class: 'room ' + room.status
      onclick: "joinroom('#{room.name}', #{room.private})" if room.status == 'wait'
    )
    if room.private
      room_html.append $('<a />',
        class: 'icon lock'
        text: "🔒"
      )
    room_html.append $('<a />',
      class: 'room_name'
      text: room.name
    )
    room_html.append ' '
    room_html.append $('<a />',
      class: 'room_id'
      text: room.id
    )
    room_html.append $('<br />')
    if user = room.player1
      room_html.append $('<a />',
        class: 'room_player'
        text: user.name
        #href: '/users/' + user.id unless user.id == 0
      )
      room_html.append $('<br />')
      $('#users').append $('<a />',
        class: 'user'
        text: user.name
        #href: '/users/' + user.id unless user.id == 0
      )
    if user = room.player2
      room_html.append $('<a />',
        class: 'room_VS'
        text: 'VS'
      )
      room_html.append ' '
      room_html.append $('<a />',
        class: "room_player"
        text: user.name
        #href: '/users/' + user.id unless user.id == 0
      )
      room_html.append $('<br />')
      $('#users').append $('<a />',
        class: "user"
        text: user.name
        #href: '/users/' + user.id unless user.id == 0
      )
    if room.status == 'wait'
      room_html.append $('<a />',
        class: 'room_status green'
        text: '等待中'
      )
    else
      room_html.append $('<a />',
        class: 'room_status red'
        text: '决斗中'
      )
    $('#rooms').append room_html

$(document).ready ->
  refresh_do(window.server.cache)

setInterval(refresh, 5000)
