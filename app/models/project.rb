class Project < ActiveRecord::Base
  attr_accessible :authorization_level, :name, :type_of_report
end
