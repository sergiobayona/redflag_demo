# frozen_string_literal: true

json.extract! task, :id, :title, :description, :work_focus, :status, :due_date, :created_by, :assigned_to, :created_at,
              :updated_at
json.url task_url(task, format: :json)
