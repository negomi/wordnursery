class Word < ActiveRecord::Base
  attr_accessible :definition, :example, :pronunciation, :name

end
