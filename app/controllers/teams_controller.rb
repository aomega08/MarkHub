class TeamsController < ApplicationController
  def index
    @teams = current_user.teams
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.users = [current_user]

    if @team.save
      self.team = @team
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])

    if @team.update(team_params)
      redirect_to teams_path
    else
      render :edit
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    redirect_to teams_path
  end

  def choose
    # Query to ensure that the user has access to the team
    self.team = current_user.teams.find_by(id: params[:id])
    redirect_to dashboard_path
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
