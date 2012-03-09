# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file:
# http://jashkenas.github.com/coffee-script/

window.deviceName = ->
  return "Kindle"      if navigator.userAgent.match /Kindle/
  return "Firefox"     if navigator.userAgent.match /Firefox/
  return "Chrome"      if navigator.userAgent.match /Chrome/
  return "Android"     if navigator.userAgent.match /Android/
  return "iPod"        if navigator.userAgent.match /iPod/
  return "iPhone"      if navigator.userAgent.match /iPhone/
  return "iPad"        if navigator.userAgent.match /iPad/
  return "BlackBerry"  if navigator.userAgent.match /BlackBerry/
  return "IE"          if navigator.userAgent.match /MSIE/
  return "Silk"        if navigator.userAgent.match /Silk/
  return "Safari"      if navigator.userAgent.match /Safari/
  return "Opera"       if navigator.userAgent.match /Opera/
  return "Netscape"    if navigator.userAgent.match /Netscape/
  return "Konqueror"   if navigator.userAgent.match /Konqueror/
  "Unknown"

window.isPhone = ->
  window.deviceName() in ["Android", "BlackBerry", "iPhone", "Chrome"]

window.mobileDevice = ->
  window.deviceName() in ["Silk", "Kindle", "Android", "BlackBerry", "iPhone", "iPod"]

window.touchDevice = ->
  window.deviceName() in ["Silk", "Kindle", "Android", "BlackBerry", "iPhone", "iPad", "iPod"]

window.iDevice = ->
  window.deviceName() in ["iPhone", "iPad", "iPod"]

window.iScrollDevice = ->
  window.deviceName() in ["iPad"]

window.topDevice = ->
  window.deviceName() in ["Android", "iPad", "iPod", "iPhone", "Silk", "Kindle"]

window.browserDevice = ->
  window.deviceName() in ["Firefox", "Chrome", "IE", "Safari", "Netscape"]

window.desktopOrIpadDevice = ->
  window.browserDevice() || window.iScrollDevice()

removeBreaks = ->
  txt = $('#bam-text').html()
  return unless txt
  mod_txt = txt.replace(/<br>/g, '<b></b>')
  $('#bam-text').html(mod_txt)
addBreaks = ->
  txt = $('#bam-text').html()
  return unless txt
  mod_txt = txt.replace(/<b><\/b>/g, '<br>')
  $('#bam-text').html(mod_txt)

alignText       = (direction)-> $('#bam-cont').css('text-align', direction)
clearRowMargin  = -> $('#banner-row').css('margin-top', '0')
setRowMargin    = -> $('#banner-row').css('margin-top', '10px')
clearLogoMargin = -> $('#bamru-logo').css('margin-top', '0')
setLogoMargin   = -> $('#bamru-logo').css('margin-top', '10px')
setDebugWidth   = (width) -> $('#cx-width').html(width)

formatDisplay = ->
  return unless location.pathname == '/'
  width = window.innerWidth
  if width >= 1200
    addBreaks()
    alignText('right')
    return
  if 1200 > width >= 765
    removeBreaks()
    alignText('right')
    setLogoMargin()
    setRowMargin()
    return
  if 765 > width >= 480
    addBreaks()
    alignText('center')
    setLogoMargin()
    setRowMargin()
    return
  if 480 > width >= 440
    alignText('center')
    removeBreaks()
    clearRowMargin()
    clearLogoMargin()
    return
  clearRowMargin()
  clearLogoMargin()
  alignText('center')
  removeBreaks()

associatesOptions =
  placement: 'left'
  animation: false
  title: "We are a San Mateo County Sheriff's resource, and Mountain Rescue Association member."

historyOptions =
  placement: 'right'
  animation: false
  title: "BAMRU is the oldest Mountain Rescue Team in California."

$(document).ready ->
  $('#associates').tooltip(associatesOptions) unless window.touchDevice()
  $('#history').tooltip(historyOptions)       :qa!
  unless window.touchDevice()
  formatDisplay()
  setDebugWidth(window.innerWidth)
  $(window).resize ->
    setDebugWidth(window.innerWidth)
    formatDisplay()


