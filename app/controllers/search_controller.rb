class SearchController < ApplicationController
  def index
    if params[:searchtype] == ">>"
      @word = Word.create(name: params[:name])
    elsif params[:searchtype] == "Randomize!"
      @word = Word.create(name: Word.get_random_word)
    end
  end
end
