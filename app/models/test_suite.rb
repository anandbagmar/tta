class TestSuite
  # To change this template use File | Settings | File Templates.
  attr_accessor :name, :failures, :errors, :time, :hostname

  def initialize(suite_info)
    @name = suite_info['name']
    @failures = suite_info['failures']
    @errors = suite_info['errors']
    @hostname = suite_info['hostname']
  end

  #def add_test
  #  @test
  #end
end