class Admin < ActiveRecord::Base

  def self.create_result_json(projects)
    json=Hash.new
    if (projects.none?)
      json["message"]="No Projects Using TTA"
    else
      projects.each do |project|
        key=project.id
        json[key]=[]
        sub_project_data = project.sub_projects.select("name , project_id , id")
        json[key].push("project_name" => project.name)
        sub_project_name=[]
        test_count=[]

        sub_project_data.each do |data|
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

  def self.add_external_dashboard(external_dashboard_name,external_dashboard_link)
    ExternalDashboard.find_or_create_by_name_and_link(external_dashboard_name,external_dashboard_link)

  end

  def self.update_external_dashboard_link(external_dashboard_name,external_dashboard_link)
    ExternalDashboard.find_by_name(external_dashboard_name).update_column("link", external_dashboard_link)
  end
end
