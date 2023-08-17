# frozen_string_literal: true

class ProtectedController < ApplicationController
  before_action :authorized

  def authorized
    redirect_to login_path unless logged_in?
  end
end
