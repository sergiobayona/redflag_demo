# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :name, :email, :title, :work_focus, :password, presence: true

  WORK_FOCUSES = %w[Development Design Business Research].freeze
end
