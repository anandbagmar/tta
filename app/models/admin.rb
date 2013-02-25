class Admin < ActiveRecord::Base

  def self.get_result_json
    sub_projects =[]
    @json=Hash.new
    projects = Project.all

    if(projects.none?)
    @json["message"]="No Projects Using TTA"
    else
    projects.each do |project|
      sub_projects = project.sub_projects.select("name , project_id , id")
      @json[project.name]=[]
      sub_projects.each do|data|
          @json[project.name].none? ? @json[project.name] = [data.name] : @json[project.name] << data.name
        end
    end
    @json = @json.to_json
    end
    @json
  end

end


#@json={
#    :project_name =>project
#}
