# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user, foreign_key: :assignee_id
  belongs_to :manager, foreign_key: :creator_id
  belongs_to :project

  STATUSES = ['not started', 'working', 'needs review', 'done', 'late'].freeze

  validates :title, :work_focus, :status, :due_date, presence: true
  validates :work_focus, inclusion: { in: User::WORK_FOCUSES }

  validates :status, inclusion: { in: STATUSES }
end
