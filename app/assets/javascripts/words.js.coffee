# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
    # $('#"<%= word.name %>"').click ->
    #     $('#"<%= word.name %>"_definitions').toggle

    changeList = (oldListId, newListId, wordId, callback) ->
        $.ajax '/words/update_word_list',
            type: 'POST'
            dataType: 'json'
            data: {old_list_id: oldListId, new_list_id: newListId, word_id: wordId}
            error: (jqXHR, textStatus, errorThrown) ->
                alert "AJAX error: #{textStatus}"
            success: (data, textStatus, jqXHR) ->
                callback()

    $('form input[name="list"]').click (event) ->
        oldListId = this.form.id.split("_")[2]
        wordId = this.id.split("_")[0]
        newListId = $("." + this.value).attr("id")
        console.log newListId

        moveItem = ->
            item = document.getElementById(wordId)
            div = document.getElementById(newListId)
            div.appendChild(item).fadeIn

        changeList(oldListId, newListId, wordId, moveItem)


