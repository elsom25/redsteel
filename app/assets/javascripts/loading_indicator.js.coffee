show_spinner = null

$(document).on 'page:fetch', ->
  show_indicator = ->
    $('.loading-indicator').show()
    $('.loading-indicator').css( 'opacity', '.6' )
  show_spinner = setTimeout( show_indicator, 500 )

$(document).on 'page:change', ->
  clearTimeout( show_spinner )
  $('.loading-indicator').css( 'opacity', '0' )
  $('.loading-indicator').hide()
