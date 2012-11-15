class JUnitXml < ActiveRecord::Base
  attr_accessible :contentxml, :name

  validates :contentxml, :presence => true
  validates :name, :presence => true

end
