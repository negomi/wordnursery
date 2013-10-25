class SearchController < ApplicationController
  def get_word
    params[:name].downcase
  end

  def get_random_word
    hash = Wordnik.word.get_random_word
    hash["word"].downcase
  end

  def get_pronunciation
    @pronunciation_array = Wordnik.word.get_text_pronunciations(@word)
    if @pronunciation_array == [] || @pronunciation_array[0]["rawType"] != "ahd-legacy"
      @pronunciation = ""
    else
      @pronunciation = @pronunciation_array[0]["raw"]
    end
  end

  def get_definitions
    @definitions_array = Wordnik.word.get_definitions(@word)
    if @definitions_array == []
        @definitions = []
    else
      @definitions = []
      @definitions_array.each do |result|
        new_entry = {}
        new_entry[:part_of_speech] = result["partOfSpeech"]
        new_entry[:definition] = result["text"]
        @definitions << new_entry
      end
      @attribution = @definitions_array[0]["attributionText"]
    end
  end

  def results
    if params[:searchtype] == "»"
      if params[:name] == ""
        @blank_error = "You can't search for nothing."
      else
        @word = get_word
      end
    elsif params[:searchtype] == "Randomize!"
      @word = get_random_word
    end
    if @word
      get_definitions

      if @definitions == []
        @not_found_error = "Sorry, we can't find a definition for #{@word}."
      else
        get_pronunciation
      end
    end
    render :results
  end
end
