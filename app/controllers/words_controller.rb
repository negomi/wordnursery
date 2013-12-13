class WordsController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def new
    @word = Word.new
  end

  def create
    current_user.lists[0].words.create(
      name: params[:word],
      pronunciation: params[:pronunciation],
      definition: params[:definitions],
      attribution: params[:attribution]
      )
    redirect_to user_lists_path(current_user.id)
  end

  def edit
  end

  def update
  end

  def update_word_list
    @oldList = List.find(params[:old_list_id].to_i)
    @newList = List.find(params[:new_list_id].to_i)
    word = Word.find(params[:word_id].to_i)
    word.lists.delete(@oldList)
    @newList.words << word
    render :json => @newList
  end

  def destroy
    word = Word.find(params[:id].to_i)
    word.destroy
    redirect_to user_lists_path(current_user.id)
  end
end
