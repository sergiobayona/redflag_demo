# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.bigint :manager_id

      t.timestamps
    end
  end
end
