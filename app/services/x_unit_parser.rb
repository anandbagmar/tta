require 'xmlsimple'

class XUnitParser

  def parse_xml(config_xml)

    config = XmlSimple.xml_in(config_xml, {'KeyAttr' => 'name'})

    puts "======================================================"
    puts config
    puts "======================================================"
    puts config['name']
    puts config['errors']
    puts config['failures']
    puts config['hostname']
    puts config['tests']
    puts config['time']
    puts "*************************************************************"
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




