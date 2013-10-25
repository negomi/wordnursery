class List < ActiveRecord::Base
  attr_accessible :name, :user_id

  has_and_belongs_to_many :words
  belongs_to :user
end
