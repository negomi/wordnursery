class SearchController < ApplicationController
  def index
    if params[:searchtype] == ">>"
      @word = Word.find_or_create_by_name(params[:name])
    elsif params[:searchtype] == "Randomize!"
      @word = Word.create(name: Word.get_random_word)
    end
  end
end
