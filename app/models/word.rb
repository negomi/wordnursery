class Word < ActiveRecord::Base
  attr_accessible :definition, :example, :pronunciation, :name

  has_and_belongs_to_many :lists
  has_many :definitions
end
