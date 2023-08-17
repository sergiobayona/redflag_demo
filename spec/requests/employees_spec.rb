# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  let!(:manager) { Manager.create!(name: 'Test Manager', email: 'manager@redflag.ai', password: '123456', title: 'Manager', work_focus: 'Management') }

  let(:user_params)  { {name: 'Test Employee', email: 'test@test.com', title: 'Employee', password: 'abcd1234', work_focus: 'Development'} }

  before do
    post login_path, params: {user: {:email => manager.email, :password => manager.password }}
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/employees'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/employees/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      post '/employees', params: { employee: user_params }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET /show' do
    let!(:employee) { Employee.create!(user_params) }

    it 'returns http success' do
      get '/employees/' + employee.id.to_s
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    let!(:employee) { Employee.create!(user_params) }

    it 'returns http success' do
      delete '/employees/' + employee.id.to_s
      expect(response).to have_http_status(:redirect)
    end
  end
end
