$ ->
  flashCallback = ->
    $(".flash-message").fadeOut(2000)
  $(".flash-message").bind 'click', (ev) =>
    $(".flash-message").fadeOut()
  setTimeout flashCallback, 3000