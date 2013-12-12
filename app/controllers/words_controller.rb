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

  def change_word_list


  end

  def edit
  end

  def update
  end

  def destroy
  end
end
