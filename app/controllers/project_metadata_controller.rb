class ProjectMetadataController < ApplicationController
  def new
      @project_meta_datum = ProjectMetaDatum.new
      @project_meta_datum.project

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @project_meta_datum }
      end
  end

  def create
      @project_meta_datum = ProjectMetaDatum.new(params[:project_meta_datum])

      respond_to do |format|
        if @project_meta_datum.save
          format.html { redirect_to @project_meta_datum, notice: 'project metadata was successfully created.' }
          format.json { render json: @project_meta_datum, status: :created, location: @project_meta_datum }
        else
          format.html { render action: "new" }
          format.json { render json: @project_meta_datum.errors, status: :unprocessable_entity }
        end
      end
  end

end
