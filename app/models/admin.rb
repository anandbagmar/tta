class Admin < ActiveRecord::Base

  def self.get_result_json

    @json=Hash.new
    projects = Project.all

    if(projects.none?)
    @json["message"]="No Projects Using TTA"
    else
    index=1
    sub_project_name= []
    sub_project_data= []
    test_count = []
    projects.each do |project|
      sub_project_data = project.sub_projects.select("name , project_id , id")
      key="PROJECT_"+index.to_s
      @json[key]=[]
      @json[key].push("project_name" => project.name)
      sub_project_name= []
      test_count = []
      sub_project_data.each do|data|
      sub_project_name.push(data.name)
        test_count.push(data.test_metadatum.length)
      end

      @json[key].push("sub_projects" => sub_project_name)
      @json[key].push("test_count" => test_count)
      key=""
      index+=1
    end

    end
    @json = @json.to_json
    @json
  end
end
