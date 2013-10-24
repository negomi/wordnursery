class WordsController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def new
  end

  def create
    Word.create(@word)
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
