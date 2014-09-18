# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  if $('body').hasClass 'welcome'
    $('<div>').text('Added by JS').appendTo('body')
