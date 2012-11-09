require 'test_helper'

class JUnitXmlsControllerTest < ActionController::TestCase
  setup do
    @j_unit_xml = j_unit_xmls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:j_unit_xmls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create j_unit_xml" do
    assert_difference('JUnitXml.count') do
      post :create, j_unit_xml: { contentxml: @j_unit_xml.contentxml, name: @j_unit_xml.name }
    end

    assert_redirected_to j_unit_xml_path(assigns(:j_unit_xml))
  end

  test "should show j_unit_xml" do
    get :show, id: @j_unit_xml
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @j_unit_xml
    assert_response :success
  end

  test "should update j_unit_xml" do
    put :update, id: @j_unit_xml, j_unit_xml: { contentxml: @j_unit_xml.contentxml, name: @j_unit_xml.name }
    assert_redirected_to j_unit_xml_path(assigns(:j_unit_xml))
  end

  test "should destroy j_unit_xml" do
    assert_difference('JUnitXml.count', -1) do
      delete :destroy, id: @j_unit_xml
    end

    assert_redirected_to j_unit_xmls_path
  end
end
