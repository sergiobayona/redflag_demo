# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject(:employee) { Employee.new }

  it 'is invalid' do
    expect(employee).to be_invalid
    expect(employee.errors[:name]).to include("can't be blank")
    expect(employee.errors[:email]).to include("can't be blank")
    expect(employee.errors[:password]).to include("can't be blank")
    expect(employee.errors[:work_focus]).to include("can't be blank")
  end

  it 'validates inclusion of work focus' do
    employee.work_focus = 'test'
    expect(employee).to be_invalid
    expect(employee.errors[:work_focus]).to include('is not included in the list')
  end
end
