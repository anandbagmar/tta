# Read about factories at https://github.com/thoughtbot/factory_girl

#FactoryGirl.define do
#
#  factory :platform , :class => Platform do
#    association :product_id, :factory => :project, :strategy => :build
#    name "TTA_sub"
#  end
#end

FactoryGirl.define do
  factory :platform, :class => Platform do
    name 'TTA_PLATFORM'
    product
  end
end
