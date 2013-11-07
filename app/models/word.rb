class Word < ActiveRecord::Base
  attr_accessible :definition, :attribution, :pronunciation, :name
  serialize :definition
  validate :entry_exists
  # validates :name, presence: true
  after_validation :lookup_word

  has_and_belongs_to_many :lists

  protected

  def entry_exists
    if name.blank?
      # FIXME Error handling doesn't work
      errors.add(:name, "You can't leave it blank.")
    elsif Wordnik.word.get_definitions(name) == []
      errors.add(:name, "We didn't find any definitions for #{name}.")
    end
  end

  def lookup_word
    # Get definitions
    definitions_array = Wordnik.word.get_definitions(self.name)
    definitions = []
    definitions_array.each do |result|
      new_entry = {}
      new_entry[:part_of_speech] = result["partOfSpeech"]
      new_entry[:definition] = result["text"]
      definitions << new_entry
    end
    # Get pronunciation
    pronunciation_array = Wordnik.word.get_text_pronunciations(self.name)
    # Check pronunciation exists and displays the correct form
    if pronunciation_array == [] || pronunciation_array[0]["rawType"] != "ahd-legacy"
      pronunciation = ""
    else
      pronunciation = pronunciation_array[0]["raw"]
    end
    # Set attributes
    unless definitions == []
      self.attribution = definitions_array[0]["attributionText"]
      self.definition = definitions
      self.pronunciation = pronunciation
    end
  end

  def self.get_random_word
    hash = Wordnik.word.get_random_word(name)
    hash["word"].downcase
  end

end
