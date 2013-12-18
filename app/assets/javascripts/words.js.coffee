# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

    # Change word list via AJAX
    changeList = (oldListId, newListId, wordId, callback) ->
        $.ajax '/words/update_word_list',
            type: 'POST'
            dataType: 'json'
            data: {old_list_id: oldListId, new_list_id: newListId, word_id: wordId}
            error: (jqXHR, textStatus, errorThrown) ->
                alert "AJAX error: #{textStatus}"
            success: (data, textStatus, jqXHR) ->
                callback()

    # Trigger word list change on click
    $('.list-icons a').click (event) ->
        oldListId = $(this).closest("div").attr("id")
        $newList = $("." + $(this).attr("name"))
        newListId = $newList.attr("id")
        wordId = $(this).data('wordId')
        $wordElement = $(this).closest("tr")

        # Append item to new list
        moveItem = ->
            $wordElement.fadeOut 400, ->
                $newList.children("table").append($wordElement)
                $wordElement.fadeIn()

        changeList(oldListId, newListId, wordId, moveItem)

    # Show word definitions
    $('.word a').click (event) ->
        word = this.name
        $('#' + word + '_definitions').slideToggle()
