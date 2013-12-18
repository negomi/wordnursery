class WordsController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def new
  end

  def create
    word = Word.find(params[:word][:id].to_i)
    current_user.lists[0].words << word
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
    render :json => word
  end

  def destroy
    word = Word.find(params[:id].to_i)
    word.destroy
    redirect_to user_lists_path(current_user.id)
  end
end
