class WordsController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def new
    @word = Word.new
  end

  def create
    @word = params[:word]
    @definitions = params[:definitions]
    @attribution = params[:attribution]
    user = current_user
    list = user.lists.find(params[:list_id])
    user.list.words.create(name: @word, definition: @definitions, attribution: @attribution)
    # Word.create(name: @word, definition: @definitions, attribution: @attribution)
    # FIXME Redirect to user's lists
    redirect_to root_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
