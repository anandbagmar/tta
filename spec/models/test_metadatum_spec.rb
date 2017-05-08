require 'spec_helper'

describe TestMetadatum do
  describe "create" do

    it "validates presence of browser_or_device name" do
      should validate_presence_of(:browser_or_device).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of type of environment" do
      should validate_presence_of(:environment).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of test_execution_machine_name" do
      should validate_presence_of(:test_execution_machine_name).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of os" do
      should validate_presence_of(:os).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of date_of_execution" do
      should validate_presence_of(:date_of_execution).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of test_category" do
      should validate_presence_of(:test_category).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of test_report_type" do
      should validate_presence_of(:test_report_type).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of branch" do
      should validate_presence_of(:branch).with_message("cannot be blank, Task not saved")
    end
  end

  describe "get_record_for_specific_date" do
    include DataHelper

    let(:integration_tests) { "INTEGRATION TESTS" }
    let(:unit_tests) { "UNIT TESTS" }

    let(:product) { create_product }
    let(:platform) { create_platform_for_product product }
    let(:be_equal_to_one) { eq(1) }

    def id_of(metadata)
      metadata.id
    end

    def be_equal_to(other)
      eql(other)
    end

    def length_of(metadata)
      metadata.length
    end

    it "distinguishes records by test category" do

      inserted_int_test_metadatatum  = create_metadatum platform, "2013-01-01", integration_tests
      inserted_unit_test_metadatatum = create_metadatum platform, "2013-01-01", unit_tests

      retrieved_int_test_metadata = get_metadata(
          platform,
          integration_tests,
          inserted_int_test_metadatatum.date_of_execution)

      retrieved_unit_test_metadata = get_metadata(
          platform,
          unit_tests,
          inserted_unit_test_metadatatum.date_of_execution)

      length_of(retrieved_int_test_metadata).should be_equal_to_one
      length_of(retrieved_unit_test_metadata).should be_equal_to_one
      id_of(retrieved_int_test_metadata.first).should be_equal_to(id_of inserted_int_test_metadatatum)
      id_of(retrieved_unit_test_metadata.first).should be_equal_to(id_of inserted_unit_test_metadatatum)

    end

    it "distinguishes records by test execution date" do

      inserted_int_test_metadatatum1 = create_metadatum platform, "2013-01-01", integration_tests
      inserted_int_test_metadatatum2 = create_metadatum platform, "2013-01-02", integration_tests

      retrieved_int_test_metadata1 = get_metadata(
          platform,
          integration_tests,
          inserted_int_test_metadatatum1.date_of_execution)

      retrieved_int_test_metadata2 = get_metadata(
          platform,
          integration_tests,
          inserted_int_test_metadatatum2.date_of_execution)

      length_of(retrieved_int_test_metadata1).should be_equal_to_one
      length_of(retrieved_int_test_metadata2).should be_equal_to_one
      id_of(retrieved_int_test_metadata1.first).should be_equal_to(id_of inserted_int_test_metadatatum1)
      id_of(retrieved_int_test_metadata2.first).should be_equal_to(id_of inserted_int_test_metadatatum2)
    end

    it "distinguishes records by platforms" do

      platform_other = create_other_platform_for_product product

      inserted_platform_metadatum       = create_metadatum platform, "2013-01-01", integration_tests
      inserted_platform_other_metadatum = create_metadatum platform_other, "2013-01-01", integration_tests

      date_of_execution = inserted_platform_metadatum.date_of_execution

      retrieved_platform_metadata = get_metadata(
          platform,
          integration_tests,
          date_of_execution)

      retrieved_platform_other_metadata = get_metadata(
          platform_other,
          integration_tests,
          date_of_execution)

      length_of(retrieved_platform_metadata).should be_equal_to_one
      length_of(retrieved_platform_other_metadata).should be_equal_to_one
      id_of(retrieved_platform_metadata.first).should be_equal_to(id_of inserted_platform_metadatum)
      id_of(retrieved_platform_other_metadata.first).should be_equal_to(id_of inserted_platform_other_metadatum)
    end
  end
end
