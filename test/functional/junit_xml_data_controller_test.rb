require 'test_helper'

class JunitXmlDataControllerTest < ActionController::TestCase
  setup do
    @junit_xml_datum = junit_xml_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:junit_xml_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create junit_xml_datum" do
    assert_difference('JunitXmlDatum.count') do
      post :create, junit_xml_datum: { classname: @junit_xml_datum.classname, errors: @junit_xml_datum.errors, failures: @junit_xml_datum.failures, hostname: @junit_xml_datum.hostname, name: @junit_xml_datum.name, tests: @junit_xml_datum.tests, timetaken: @junit_xml_datum.timetaken }
    end

    assert_redirected_to junit_xml_datum_path(assigns(:junit_xml_datum))
  end

  test "should show junit_xml_datum" do
    get :show, id: @junit_xml_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @junit_xml_datum
    assert_response :success
  end

  test "should update junit_xml_datum" do
    put :update, id: @junit_xml_datum, junit_xml_datum: { classname: @junit_xml_datum.classname, errors: @junit_xml_datum.errors, failures: @junit_xml_datum.failures, hostname: @junit_xml_datum.hostname, name: @junit_xml_datum.name, tests: @junit_xml_datum.tests, timetaken: @junit_xml_datum.timetaken }
    assert_redirected_to junit_xml_datum_path(assigns(:junit_xml_datum))
  end

  test "should destroy junit_xml_datum" do
    assert_difference('JunitXmlDatum.count', -1) do
      delete :destroy, id: @junit_xml_datum
    end

    assert_redirected_to junit_xml_data_path
  end
end
