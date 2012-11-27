require 'xmlsimple'

module XUnitParser

  def parse_xml(config_xml)

    config = XmlSimple.xml_in(config_xml, {'KeyAttr' => 'name'})

    xml_data = TestRecord.new(
                                  :classname => config['name'],
                                 :errorsintest => config['errors'],
                                 :failures => config['failures'],
                                 :hostname => config['hostname'],
                                 :name =>config['name'],
                                 :tests => config['tests'],
                                 :timetaken => config['time'])
    puts ("************************************************")
    puts xml_data
    puts xml_data.class_name
    xml_data.save
  end
end




