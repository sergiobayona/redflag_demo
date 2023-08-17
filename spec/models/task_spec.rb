# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  subject(:task) { Task.new }

  it 'returns validation errors' do
    expect(task).to be_invalid
    expect(task.errors[:title]).to include("can't be blank")
    expect(task.errors[:work_focus]).to include("can't be blank")
    expect(task.errors[:status]).to include("can't be blank")
    expect(task.errors[:user]).to include('must exist')
    expect(task.errors[:manager]).to include('must exist')
    expect(task.errors[:project]).to include('must exist')
    expect(task.errors[:due_date]).to include("can't be blank")
  end

  it 'returns an error if work focus is not in the list' do
    task.work_focus = 'Work Focus 1'
    expect(task).to be_invalid
    expect(task.errors[:work_focus]).to include('is not included in the list')
  end

  it 'returns an error if status is not in the list' do
    task.status = 'Status 1'
    expect(task).to be_invalid
    expect(task.errors[:status]).to include('is not included in the list')
  end

  it 'is valid' do
    task.title = 'Task 1'
    task.work_focus = 'Development'
    task.status = 'not started'
    task.due_date = Time.zone.today
    task.user = User.new
    task.manager = Manager.new
    task.project = Project.new
    expect(task).to be_valid
  end

  it 'has statuses' do
    expect(Task::STATUSES).to eq(['not started', 'working', 'needs review', 'done', 'late'])
  end

  it 'belongs to a user' do
    expect(Task.reflect_on_association(:user).macro).to eq(:belongs_to)
  end

  it 'belongs to a manager' do
    expect(Task.reflect_on_association(:manager).macro).to eq(:belongs_to)
  end

  it 'belongs to a project' do
    expect(Task.reflect_on_association(:project).macro).to eq(:belongs_to)
  end
end
