# Read about factories at https://github.com/thoughtbot/factory_girl
#
#FactoryGirl.define do
#  factory :project ,:class => Project do
#    name "TTA"
#    authorization_level "All"
#  end
#end
FactoryGirl.define do
  factory :project , :class => Project do  |f|
    f.name 'TTA'
    f.authorization_level 'ALL'
  end

end
