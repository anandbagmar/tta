class UnitTestXml < ActiveRecord::Base
  attr_accessible :xml_file_name
  has_attached_file :xml
end
