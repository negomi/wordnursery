# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
    # $('#"<%= word.name %>"').click ->
    #     $('#"<%= word.name %>"_definitions').toggle

    changeList = (oldListId, newListId, wordId) ->
        $.ajax(
            url: '/words/update_word_list',
            type: 'POST',
            data: {old_list_id: oldListId, new_list_id: newListId, word_id: wordId}
            ).done (data) ->
                console.log data

    $('form input[name="list"]').click (event) ->
        idArr = this.form.id.split("_")
        oldListId = idArr[2]
        wordId = this.id.split("_")[0]
        newListId = $("." + this.value).attr("id")
        console.log(oldListId, newListId, wordId)
        changeList(oldListId, newListId, wordId)

