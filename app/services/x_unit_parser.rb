require 'xmlsimple'

class XUnitParser

  def parse_xml(config_xml)

    config = XmlSimple.xml_in(config_xml, {'KeyAttr' => 'name'})

    xml_data = JunitXmlDatum.new(:classname => config['name'],
                                 :errorsintest => config['errors'],
                                 :failures => config['failures'],
                                 :hostname => config['hostname'],
                                 :name =>config['name'],
                                 :tests => config['tests'],
                                 :timetaken => config['time'])
    xml_data.save
  end
end




