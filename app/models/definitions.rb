class Definitions < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :word
end
