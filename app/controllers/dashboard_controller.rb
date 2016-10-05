class DashboardController < ApplicationController
  before_action :ensure_authenticated
  before_action :ensure_team

  def index
  end
end
