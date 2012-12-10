class VisualizationController < ApplicationController

  def pyramid
  end

  def sub_project_filter


      sub_project_id=params[:sub_project][:id]
      p "start time:"
      p Time.now
      result_set1 = Visualization.getNoOfTests(sub_project_id,"Functional Test")
      p result_set1
      p Time.now
      result_set2 = Visualization.getNoOfTests(sub_project_id,"Unit Test")
      p result_set2
      p Time.now
      result_set3 = Visualization.getNoOfTests(sub_project_id,"Integration Test")
      p result_set3
      p Time.now
      p ("*")*100
      p "end time:"
      p Time.now

      @no_of_unit_test = result_set2[0][0]
      @no_of_Integration_test = result_set3[0][0]
      @no_of_functional_test = result_set1[0][0]
      @jsonData = Pyramid.new(500, [[:unit ,@no_of_unit_test],[:integration , @no_of_Integration_test],[:functional, @no_of_functional_test]]).to_json

      @sub_project_name = SubProject.find(sub_project_id).name
      calculate_percentage_of_tests
      @duration_functional=calculate_duration_in_hours(result_set1)
      @duration_unit=calculate_duration_in_hours(result_set2)
      @duration_integration=calculate_duration_in_hours(result_set3)
      #calculate_label_positions
      render :pyramid


  end

  def calculate_duration_in_hours(result_set)
    time = "%0.4f" % (result_set[0][1].to_f/60000)
    return time
  end

  def calculate_percentage_of_tests
    @total = @no_of_unit_test.to_f + @no_of_functional_test.to_f + @no_of_Integration_test.to_f
    @percent_unit_test = "%0.2f" % ((@no_of_unit_test/@total) *100)
    @percent_functional_test = "%0.2f" % ((@no_of_functional_test/@total) *100)
    @percent_integration_test = "%0.2f" % ((@no_of_Integration_test/@total) *100)

  end
  def calculate_label_positions
    @unit_position= ((500/@total)* @no_of_unit_test.to_f)
    @functional_position=  ((500/@total)* @no_of_funtionl_test.to_f)
    @integration_position=  ((500/@total)* @no_of_Integration_test.to_f)
  end
 



end
