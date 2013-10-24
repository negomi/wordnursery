class WordsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def search
    get_word
    get_pronunciation
    get_definitions
    render :results
  end

  def get_word
    @word = params[:word][:name].downcase
  end

  def get_pronunciation
    @pronunciation_array = Wordnik.word.get_text_pronunciations(get_word)
    @pronunciation = @pronunciation_array[0]["raw"]
  end

  def get_definitions
    @definitions_array = Wordnik.word.get_definitions(get_word, :source_dictionaries => "ahd")
    @definitions = []
    @definitions_array.each do |hash|
      new_entry = {}
      new_entry[:part_of_speech] = hash["partOfSpeech"]
      new_entry[:definition] = hash["text"]
      @definitions << new_entry
    end
    @attribution = @definitions_array[0]["attributionText"]
  end

  def show
  end

  def new
  end

  def create
    word = Word.create(get_word)
  end

  def edit
  end

  def update
  end

  def delete
  end

end
