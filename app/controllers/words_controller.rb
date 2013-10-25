class WordsController < ApplicationController
  # before_filter :authenticate_user!

  def show
  end

  def new
    @word = Word.new
  end

  def create
    @word = params[:word]
    @definitions = params[:definitions]
    @attribution = params[:attribution]
    Word.create(name: @word, definition: @definitions, attribution: @attribution)
    redirect_to root_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
