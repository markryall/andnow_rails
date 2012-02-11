//= require jquery.hotkeys

$(document).bind 'keydown', 'ctrl+l', ->
  window.location = '/sessions'

$(document).bind 'keydown', 'ctrl+n', ->
  window.location = '/sessions/new'

$(document).bind 'keydown', 'ctrl+s', ->
  $('#new_session').submit()

$(document).bind 'keydown', 'ctrl+e', ->
  now = new Date()
  ts = now.getTime()
  rounded = Math.ceil(ts/1000)
  $('#session_end_time').val rounded
