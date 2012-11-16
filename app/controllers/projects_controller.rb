class ProjectsController < ApplicationController

    def index
      @projects = Project.all

      respond_to do |format|
        format.html
        format.json { render json: @projects }
      end
    end

    def show
      @project = Project.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @project }
      end
    end

    def new
      @project = Project.new

      respond_to do |format|
        format.html
        format.json { render json: @project }
      end
    end

    def edit
      @project = Project.find(params[:id])
    end

    def create
      @project = Project.new(params[:project])

      respond_to do |format|
        if @project.save
          format.html { redirect_to @project, notice: 'project was successfully created.' }
          format.json { render json: @project, status: :created, location: @project }
        else
          format.html { render action: "new" }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      @project = Project.find(params[:id])

      respond_to do |format|
        if @project.update_attributes(params[:project])
          format.html { redirect_to @project, notice: 'Project was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @project = Project.find(params[:id])
      @project.destroy

      respond_to do |format|
        format.html { redirect_to projects/index }
        format.json { head :no_content }
      end
    end
end
