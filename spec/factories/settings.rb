FactoryGirl.define do
  factory :setting, :class => Refinery::Setting do
    sequence(:name, 'Refinery CMS setting') {|n| "Refinery CMS setting #{n}" }
  end
end
