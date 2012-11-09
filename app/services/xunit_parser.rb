require 'xmlsimple'
require '../models/test_suite'

class XUnitParser

  def parse_xml
    config = XmlSimple.xml_in('AccountAdminControllerTest.xml', {'KeyAttr' => 'name'})

    #puts config[name]
    suite_info = {"name" => config['name'], "failures" => config['failures'], "errors" => config['errors'], "hostname" => config['hostname']}

    suite = get_suite_info(suite_info)
    puts suite.failures
  end

  # To change this template use File | Settings | File Templates.


  def get_suite_info(suite_info)
    puts suite_info
    return TestSuite.new(suite_info)
  end

end

XUnitParser.new.parse_xml




