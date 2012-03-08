# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

removeBreaks = ->
  txt = $('#bam-mesg').html().replace(/<br>/g, '<b></b>')
  $('#bam-mesg').html(txt)

addBreaks = ->
  txt = $('#bam-mesg').html()?.replace(/<b><\/b>/g, '<br>')
  $('#bam-mesg').html(txt)

alignText       = (direction)-> $('#bam-text').css('text-align', direction)
clearRowMargin  = -> $('#banner-row').css('margin-top', '0')
setRowMargin    = -> $('#banner-row').css('margin-top', '10px')
clearLogoMargin = -> $('#bamru-logo').css('margin-top', '0')
setLogoMargin   = -> $('#bamru-logo').css('margin-top', '10px')
setDebugWidth   = -> $('#current-width').html(window.innerWidth)

formatDisplay = (width) ->
  setDebugWidth()
  setDebugWidth()
  if width > 980
    addBreaks()
    alignText('right')
    return
  if 980 > width > 765
    removeBreaks()
    alignText('right')
    return
  if 765 > width > 480
    addBreaks()
    alignText('center')
    setLogoMargin()
    setRowMargin()
    return
  if 480 > width > 440
    alignText('center')
    removeBreaks()
    clearRowMargin()
    clearLogoMargin()
    return
  clearRowMargin()
  clearLogoMargin()
  alignText('center')
  removeBreaks()

hoverOptions =
  placement: 'left'
  title: "BAMRU is a resource of the San Mateo County Sheriff's Office of Emergency Services, and a proud member of the Mountain Rescue Association (MRA)."

$(document).ready ->
  $('#associates').tooltip(hoverOptions)
  formatDisplay(window.innerWidth)
  window.onresize = -> formatDisplay(window.innerWidth)


