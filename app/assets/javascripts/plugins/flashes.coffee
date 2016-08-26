hide_flash = window.setTimeout ->
  $('.alert').fadeOut(2000)
, 3500

$ ->
  hide = window.setTimeout ->
    $('.alert').fadeOut(2000)
  , 2000

  $(document).on 'mouseover', '.alert', ->
    window.clearTimeout(hide)
    $('.alert').stop().animate({opacity: '100'})

  $(document).on 'mouseout', '.alert', ->
    hide = hide_flash
