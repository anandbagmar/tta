# Read about factories at https://github.com/thoughtbot/factory_girl


FactoryGirl.define do
  factory :project do
    name "TTA"
    authorization_level "All"

  end


  factory :sub_project  do
   name "TTA_sub"
    association :project_id , :factory => :project

  end
end
