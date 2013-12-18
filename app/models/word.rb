class Word < ActiveRecord::Base
  attr_accessible :name, :pronunciation, :definition, :attribution
  serialize :definition
  # Callback method to verify existence
  validate :entry_exists
  validates :name, :presence => true, :uniqueness => true
  before_save :lookup

  has_and_belongs_to_many :lists

  protected

  def self.get_random_word
    hash = Wordnik.word.get_random_word(name)
    hash["word"].downcase
  end

  def entry_exists
    # Error if the user searched for nothing
    if name.blank?
      errors.add(:name, "You didn't type anything.")
    # Error if word doesn't exist in DB and doesn't have definitions
    elsif !Word.exists?(name: name) && Wordnik.word.get_definitions(name) == []
      errors.add(:name, "We didn't find any definitions for #{name}.")
    end
  end

  def lookup
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
end
