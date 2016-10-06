class TwitterController < ApplicationController
  def show
    @account = team.social_entities.find_by!(network: 'twitter', network_id: params[:id])
  end
end
