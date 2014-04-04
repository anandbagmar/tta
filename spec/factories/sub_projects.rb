# Read about factories at https://github.com/thoughtbot/factory_girl

#FactoryGirl.define do
#
#  factory :sub_project , :class => SubProject do
#    association :project_id, :factory => :project, :strategy => :build
#    name "TTA_sub"
#  end
#end

FactoryGirl.define do
  factory :sub_project , :class => SubProject   do

    name 'TTA_subProject'
    project
  end

end