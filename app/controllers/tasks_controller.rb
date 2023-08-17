# frozen_string_literal: true

class TasksController < ProtectedController
  before_action :set_project
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = @project.tasks.build
  end

  def edit; end

  def create
    manager = Manager.find_by(id: session[:user_id])
    @task = @project.tasks.build(task_params)
    @task.manager = manager

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_url(@project), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_url(@project), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to project_url(@project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :description, :work_focus, :status, :due_date, :assignee_id)
  end
end
