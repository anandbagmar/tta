require 'ftools'
require 'zip/zipfilesystem'
require 'nokogiri'



class UploadController < ApplicationController
  def create
    meta_datum, project, sub_project = create_or_update_meta_datum_and_dependency
      save_log_files(meta_datum)
      redirect_to :action => :show, :project_id => project.id, :sub_project_id => sub_project.id, :project_meta_id => meta_datum.id
  end

  def show
    @project = Project.find(params[:project_id])
    @sub_project= @project.sub_projects.find(params[:sub_project_id])
    @project_meta = @sub_project.test_metadatum.find(params[:project_meta_id])
    begin
      respond_to do |format|
        flash[:notice] = "Project Successfully Saved!!"
        format.html
        format.json { render json: @project }
      end
    end
  end

  private
  def create_or_update_meta_datum_and_dependency
    project = Project.find_or_create_by_name(params[:project_name].upcase)
        sub_project = project.sub_projects.find_or_create_by_name(params[:sub_project_name].upcase)
              meta_datum = sub_project.test_metadatum.find_or_create_by_ci_job_name_and_browser_and_type_of_environment_and_host_name_and_os_name_and_test_category_and_test_report_type(params[:ci_job_name].upcase,
                                                                                                                                                                                         params[:browser].upcase, params[:type_of_environment].upcase, params[:host_name].upcase, params[:os_name].upcase, params[:test_category].upcase, params[:test_report_type].upcase)
    meta_datum.date_of_execution= params[:date_of_execution]
    meta_datum.save
    return meta_datum, project, sub_project
  end

  def save_log_files(meta_datum)
    dir_path = create_directory_structure()
    file = File.join(dir_path, params[:logDirectory].original_filename)
    FileUtils.cp params[:logDirectory].tempfile.path, file
    Zip::ZipFile.open(file) do |zipFile|
      zipFile.each do |entry|
        filename=entry.to_s
        contents = zipFile.read(entry)
        contents_string= contents.to_s
        if filename =~ /\.xml$/
          if contents_string.start_with? ("<?xml")
            parse_xml(contents, meta_datum.id)
          end
        end
      end
    end
  end

  def create_directory_structure
    dir_path = "/Users/pooja/Documents/tta/logs/"+params[:project_name]
    Dir.mkdir(dir_path, 0777) unless File.exists?(dir_path)
    dir_path = dir_path+"/"+params[:sub_project_name]
    Dir.mkdir(dir_path, 0777) unless File.exists?(dir_path)
    dir_path = dir_path+"/"+Time.now.strftime("%d-%m-%y-%I:%M:%S")
    Dir.mkdir(dir_path, 0777) unless File.exists?(dir_path)
    dir_path
  end


  def parse_xml(config_xml, meta_id)
    myfile=File.new("temp_log.xml", "w")
    myfile.puts config_xml
    myfile.close
    @doc = Nokogiri::Slop(File.open("temp_log.xml"))
    @doc.xpath("//testsuite").each do |p|
      time = 0
      @xml_data = TestSuiteRecord.new()
      @xml_data.test_metadatum_id=meta_id
      @xml_data.class_name= p.attr("name")
      @xml_data.number_of_tests= p.attr("tests")
      @xml_data.number_of_errors= p.attr("errors")
      @xml_data.number_of_failures= p.attr("failures")
      @doc.xpath("//testsuite/testcase").each do |q|
        if q.attr("name").start_with? (p.attr("name")+" ")
          time += q.attr("time").to_f
        end
      end
      @xml_data.time_taken = time.to_s
      @xml_data.save
      @doc.xpath("//testsuite/testcase").each do |q|
        if q.attr("name").start_with? (p.attr("name")+" ")
          @xml_test_case = TestCaseRecord.new()
          @xml_test_case.test_suite_record_id= @xml_data.id
          @xml_test_case.class_name = q.attr("name")
          testcase_name=q.attr("name")
          @xml_test_case.time_taken = q.attr("time")
          if @xml_data.number_of_failures.to_i > 0
             @doc.xpath("//testsuite/testcase/failure").each do |w|
               node = Nokogiri::XML config_xml
               cdata = node.search("//testsuite/testcase[@name='#{testcase_name}']/failure").children.find{|e| e.cdata?}
               str = cdata.to_s
               str1=str.scan(/\[CDATA\[((.|\s)*)\]\]/m).first
               @xml_test_case.error_msg = str1
            end
          end
          @xml_test_case.save

        end
      end
    end
    File.delete("temp_log.xml")
  end


end



