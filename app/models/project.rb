# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :users, -> { distinct }, through: :tasks
  belongs_to :manager

  validates :title, :due_date, :description, presence: true
  validates :title, uniqueness: true
  validate :due_date_cannot_be_in_the_past

  def due_date_cannot_be_in_the_past
    return unless due_date.present? && due_date < Time.zone.today

    errors.add(:due_date, "can't be in the past")
  end
end
