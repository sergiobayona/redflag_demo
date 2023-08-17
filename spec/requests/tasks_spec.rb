# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/tasks', type: :request do
  let!(:manager) do
    Manager.create!(name: 'Test Manager', email: 'manager@redflag.ai', password: '123456', title: 'Manager',
                    work_focus: 'Management')
  end
  let!(:employee) do
    Employee.create!(name: 'Tom Brady', email: 'tome@redflag.ai', password: '123456', title: 'Developr',
                     work_focus: 'Development')
  end
  let!(:project) do
    Project.create!(title: 'Test Project', description: 'Test Project Description', due_date: 1.month.from_now,
                    manager:)
  end

  let(:valid_attributes) do
    {
      title: 'Task 1',
      description: 'task desc',
      due_date: 1.month.from_now,
      manager:,
      user: employee,
      project:,
      work_focus: 'Development',
      status: 'not started'
    }
  end

  let(:invalid_attributes) do
    { title: 'test', work_focus: 'bad' }
  end

  before do
    post login_path, params: { user: { email: manager.email, password: manager.password } }
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_project_task_url(project)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      task = Task.create! valid_attributes
      get edit_project_task_url(project, task)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          title: 'task 2',
          description: '',
          work_focus: 'Development',
          status: 'not started',
          due_date: 1.month.from_now,
          assignee_id: employee.id
        }
      end

      it 'creates a new Task' do
        expect do
          post project_tasks_url(project), params: { task: valid_params }
        end.to change(Task, :count).by(1)
      end

      it 'redirects to the created task' do
        post project_tasks_url(project), params: { task: valid_params }
        expect(response).to redirect_to(project_url(project))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Task' do
        expect do
          post project_tasks_url(project), params: { task: invalid_attributes }
        end.to change(Task, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post project_tasks_url(project), params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested task' do
        task = Task.create! valid_attributes
        patch project_task_url(project, task), params: { task: new_attributes }
        task.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the task' do
        task = Task.create! valid_attributes
        patch project_task_url(project, task), params: { task: new_attributes }
        task.reload
        expect(response).to redirect_to(project_task_url(project, task))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        task = Task.create! valid_attributes
        patch project_task_url(project, task), params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested task' do
      task = Task.create! valid_attributes
      expect do
        delete project_task_url(project, task)
      end.to change(Task, :count).by(-1)
    end

    it 'redirects to the tasks list' do
      task = Task.create! valid_attributes
      delete project_task_url(project, task)
      expect(response).to redirect_to(project_url(project))
    end
  end
end
