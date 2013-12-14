# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

    changeList = (oldListId, newListId, wordId, callback) ->
        $.ajax '/words/update_word_list',
            type: 'POST'
            dataType: 'json'
            data: {old_list_id: oldListId, new_list_id: newListId, word_id: wordId}
            error: (jqXHR, textStatus, errorThrown) ->
                alert "AJAX error: #{textStatus}"
            success: (data, textStatus, jqXHR) ->
                callback()

    $('.list-icons a').click (event) ->
        selected = this
        oldListId = $(selected).data('listId')
        newListId = $("." + selected.name).attr("id")
        wordId = $(selected).data('wordId')
        wordElement = $(selected).parents()[1]

        moveItem = ->
            newList = document.getElementById(newListId).children[0]
            $(wordElement).data('listId', newListId)
            $(newList).append(wordElement).fadeIn()

        $(wordElement).fadeOut() ->
            changeList(oldListId, newListId, wordId, moveItem)

    $('.word a').click (event) ->
        word = this.name
        $('#' + word + '_definitions').slideToggle()
