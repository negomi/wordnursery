class WordsController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def new
    @word = Word.new
  end

  def create
    user = current_user
    user.lists[0].words.create(
      name: params[:word],
      pronunciation: params[:pronunciation],
      definition: params[:definitions],
      attribution: params[:attribution]
      )
    redirect_to user_lists_path(user.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
