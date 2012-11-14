class JunitXmlDatum < ActiveRecord::Base
  attr_accessible :classname, :errorsintest, :failures, :hostname, :name, :tests, :timetaken
end
