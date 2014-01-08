# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

    $graduatedWords = $('.graduated')
    $graduatedLink = $('#show-graduated')
    $clearLink = $('#clear-graduated')

    # Hide graduated words & clear link by default
    $graduatedWords.add($clearLink).hide()

    # Show graduated words on click
    $graduatedLink.click (event) ->
        event.preventDefault()
        $graduatedWords.slideToggle ->
            if $graduatedWords.is(':visible')
                $graduatedLink[0].innerHTML = '<p>Hide graduated words &uarr;</p>'
                $clearLink.show()
            else
                $graduatedLink[0].innerHTML = '<p>Show graduated words &darr;</p>'
                $clearLink.hide()
