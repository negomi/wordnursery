# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

    $graduatedWords = $('.graduated')
    $graduatedLink = $('#show-graduated')

    # Hide graduated words by default
    $graduatedWords.hide()

    # Show graduated words on click
    $graduatedLink.click (event) ->
        event.preventDefault()
        $graduatedWords.slideToggle () ->
            if $graduatedWords.is(':visible')
                $graduatedLink[0].innerHTML = '<p>Hide graduated words &uarr;</p>'
            else
                $graduatedLink[0].innerHTML = '<p>Show graduated words &darr;</p>'
