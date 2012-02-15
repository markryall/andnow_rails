//= require jquery.hotkeys

$(document).bind 'keydown', 'ctrl+l', ->
  window.location = '/sessions'

$(document).bind 'keydown', 'ctrl+n', ->
  window.location = '/sessions/new'

$(document).bind 'keydown', 'ctrl+s', ->
  $('#save').submit()

$(document).bind 'keydown', 'ctrl+e', ->
  now = new Date()
  ts = now.getTime()
  rounded = Math.ceil(ts/1000)
  $('#session_end_time').val rounded

index = 0

$(document).bind 'keydown', 'j', ->
  $('tbody > tr').eq(index).attr 'class', ''
  index += 1
  $('tbody > tr').eq(index).attr 'class', 'row_selected'

$(document).bind 'keydown', 'k', ->
  $('tbody > tr').eq(index).attr 'class', ''
  index -= 1
  $('tbody > tr').eq(index).attr 'class', 'row_selected'

$(document).bind 'keydown', 'e', ->
  window.location = $('a.e').eq(index).attr('href');

$ ->
  $('.focused').trigger 'focus'
  $('tbody > tr').eq(index).attr 'class', 'row_selected'