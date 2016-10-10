class TwitterController < ApplicationController
  def show
    entity = team.social_entities.find_by!(network: 'twitter', network_id: params[:id])
    @account = TwitterAccount.new(entity)
  end
end
