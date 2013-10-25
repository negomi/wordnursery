class Word < ActiveRecord::Base
  attr_accessible :definition, :attribution, :pronunciation, :name
  serialize :definition

  has_and_belongs_to_many :lists
end
