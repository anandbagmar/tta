class JunitXmlDatum < ActiveRecord::Base
  attr_accessible :classname, :errors, :failures, :hostname, :name, :tests, :timetaken
end
