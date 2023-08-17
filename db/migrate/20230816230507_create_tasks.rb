# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :work_focus
      t.string :status
      t.date :due_date
      t.bigint :creator_id
      t.bigint :assignee_id
      t.bigint :project_id

      t.timestamps
    end
  end
end
