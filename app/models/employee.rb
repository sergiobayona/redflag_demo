# frozen_string_literal: true

class Employee < User
  has_secure_password

  validates :name, :email, :title, :work_focus, :password, presence: true
  validates :email, uniqueness: true
  validates :work_focus, inclusion: { in: User::WORK_FOCUSES }
end
