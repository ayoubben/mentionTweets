recount = ->
  maxlen = 140
  current = maxlen - ($('#inputField').val().length)
  $('.counter').html current
  if current < 0 or current == maxlen
    $('.counter').css 'color', '#D40D12'
    $('input.submitButton').attr('disabled', 'disabled').addClass 'inact'
  else
    $('input.submitButton').removeAttr('disabled').removeClass 'inact'
  if current < 10
    $('.counter').css 'color', '#D40D12'
  else if current < 20
    $('.counter').css 'color', '#5C0002'
  else
    $('.counter').css 'color', '#000'

$(document).ready ->
  $('#inputField').bind 'blur focus keydown keypress keyup', ->
    recount()
