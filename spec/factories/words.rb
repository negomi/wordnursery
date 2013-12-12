# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :word do
    name 'example'
    pronunciation '(ĭg-zămˈpəl)'
    definition 'One that is representative of a group as a whole: the squirrel, an example of a rodent; introduced each new word with examples of its use.'
    attribution 'from The American Heritage® Dictionary of the English Language, 4th Edition'
  end
end
