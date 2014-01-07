class WordsController < ApplicationController
  before_filter :authenticate_user!, except: [:create]

  def show
  end

  def new
  end

  def create
    word = session[:word] || Word.find(params[:word][:id].to_i)
    # Check if user is logged in
    if current_user
      # Check if user already has the word saved
      current_words = current_user.lists.map { |list| list.words }
      if current_words.flatten.include?(word)
        redirect_to :back, flash: { error: "You've already saved '#{word.name}'" }
      else
        current_user.lists[0].words << word
        redirect_to user_lists_path(current_user.id)
      end
    else
      session[:word] = word
      redirect_to user_session_path, flash: { error: "You need to be signed in to save words." }
    end
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
