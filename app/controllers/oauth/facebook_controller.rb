module OAuth
  class FacebookController < ApplicationController
    FACEBOOK_PERMISSIONS = %w(email read_insights publish_actions publish_pages
                              manage_pages user_photos).freeze

    before_action :save_page_ids, only: :pages
    before_action :ensure_access_token

    rescue_from Koala::Facebook::OAuthTokenRequestError, with: -> { redirect_to oauth_choose_facebook_pages_path }

    def index
      @pages = get_facebook_pages(choose_oauth, params[:code])
    end

    def pages
      @pages = get_facebook_pages(add_oauth, params[:code], session.delete(:adding_page_ids))
      # Add selected pages to Team
    end

    private

    def save_page_ids
      session[:adding_page_ids] = params[:pages] if params[:pages]
    end

    def ensure_access_token
      unless params[:code]
        oauth = action_name == 'index' ? choose_oauth : add_oauth
        redirect_to oauth.url_for_oauth_code(permissions: FACEBOOK_PERMISSIONS)
      end
    end

    def choose_oauth
      @choose_oauth ||= oauth(oauth_choose_facebook_pages_url)
    end

    def add_oauth
      @add_oauth ||= oauth(oauth_add_facebook_pages_url)
    end

    def oauth(redirect_uri)
      Koala::Facebook::OAuth.new(ENV['facebook_app_id'],
                                 ENV['facebook_app_secret'],
                                 redirect_uri)
    end

    def get_facebook_pages(oauth, code, filter_page_ids = nil)
      user_access_token = oauth.get_access_token(code)
      user_graph = Koala::Facebook::API.new(user_access_token)
      pages = user_graph.get_connections('me', 'accounts')

      if filter_page_ids
        pages.select { |page| page['id'].in?(filter_page_ids) }
      else
        pages
      end
    end
  end
end
