class Admin < ActiveRecord::Base

  def self.create_result_json(projects)
    json=Hash.new
    if(projects.none?)
    json["message"]="No Projects Using TTA"
    else
      sub_project_name= []
      sub_project_data= []
      test_count = []
      key=""
      projects.each do |project|
        key=project.id
        json[key]=[]
        sub_project_data = project.sub_projects.select("name , project_id , id")
        json[key].push("project_name" => project.name)
        sub_project_name=[]
        test_count=[]

          sub_project_data.each do|data|
              sub_project_name.push(data.name)
              test_count.push(data.test_metadatum.length)
          end

      json[key].push("sub_projects" => sub_project_name)
      json[key].push("test_count" => test_count)
    end
    end
    return json
  end




  def self.get_result_json(projects= {})
     @json=create_result_json(projects)
     @json = @json.to_json
     @json
  end
end
