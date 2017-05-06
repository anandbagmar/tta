SAMPLE_TEST_SUB_CATEGORY = YAML.load(File.open("#{Rails.root}/config/test_category_mapping.yml", "r"))

SAMPLE_TEST_CATEGORIES = []
SAMPLE_TEST_SUB_CATEGORY.each do |testCategoryMapping|
  SAMPLE_TEST_CATEGORIES << testCategoryMapping.first
end

SAMPLE_BROWSER_OR_DEVICE_TYPES= %w( chrome firefox IE opera safari seamonkey k-meleon conqueror maxthon galleon avant netscape iCab camino flock )
SAMPLE_OS_TYPES= ["Mac", "Unix", "Ubuntu", "BeOS", "IRIX", "NeXTSTEP", "MS-DOS", "iOS", "Windows7", "kondara linux", "OSF", "QNX", "SCO", "sunSolaris", "SuSELinux"]
SAMPLE_TEST_EXECUTION_MACHINE_NAMES= %w(garima pooja ashwin nikita nikitha tushar matty lava priti sailee sanchari shilpa pranjali akshay aasawaree)
SAMPLE_CI_JOB_NAMES= %w(smoke master regression runtest testomania enternet titanic kanha kaziranga stress opensaysme gir test4treasure quovadis nihao)
SAMPLE_TEST_ENVIRONMENTS = %w(dev qa production uat)
SAMPLE_TEST_REPORT_TYPES = ["JUnit", "Cucumber_HTML", "NUnit"]
