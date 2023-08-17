# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  subject(:project) { Project.new }

  it 'is invalid' do
    expect(project).to be_invalid
    expect(project.errors[:title]).to include("can't be blank")
    expect(project.errors[:description]).to include("can't be blank")
    expect(project.errors[:due_date]).to include("can't be blank")
  end

  it 'validate due date cannot be in the past' do
    project.due_date = Time.zone.today - 1
    expect(project).to be_invalid
    expect(project.errors[:due_date]).to include("can't be in the past")
  end

  it 'has no task when new' do
    expect(project.tasks).to eq([])
  end
end
