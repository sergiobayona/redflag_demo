# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/projects', type: :request do
  let!(:manager) { Manager.create!(name: 'Test Manager', email: 'manager@redflag.ai', password: '123456', title: 'Manager', work_focus: 'Management') }

  let(:valid_attributes) do
    { title: 'Test Project', description: 'Test Project Description', due_date: 1.month.from_now, manager_id: manager.id}
  end

  let(:invalid_attributes) do
    { title: nil, description: nil, due_date: nil, manager_id: nil}
  end

  before do
    post login_path, params: {user: {:email => manager.email, :password => manager.password }}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Project.create! valid_attributes
      get projects_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      project = Project.create! valid_attributes
      get project_url(project)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_project_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      project = Project.create! valid_attributes
      get edit_project_url(project)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Project' do
        expect do
          post projects_url, params: { project: valid_attributes }
        end.to change(Project, :count).by(1)
      end

      it 'redirects to the created project' do
        post projects_url, params: { project: valid_attributes }
        expect(response).to redirect_to(project_url(Project.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Project' do
        expect do
          post projects_url, params: { project: invalid_attributes }
        end.to change(Project, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post projects_url, params: { project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { title: 'New Project Title', description: 'New Project Description', due_date: 1.month.from_now, manager_id: manager.id}
      end

      it 'redirects' do
        project = Project.create! valid_attributes
        patch project_url(project), params: { project: new_attributes }
        project.reload
        expect(response).to redirect_to("/projects/#{project.id}")
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        project = Project.create! valid_attributes
        patch project_url(project), params: { project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested project' do
      project = Project.create! valid_attributes
      expect do
        delete project_url(project)
      end.to change(Project, :count).by(-1)
    end

    it 'redirects to the projects list' do
      project = Project.create! valid_attributes
      delete project_url(project)
      expect(response).to redirect_to(projects_url)
    end
  end
end
