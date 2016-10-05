class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  protected

  def authentication
    @authentication ||= Authentication.new(self)
  end

  def current_user
    @current_user ||= authentication.current_user
  end

  def ensure_authenticated
    redirect_to signin_path(continue: request.fullpath) unless current_user
  end

  def ensure_not_authenticated
    redirect_to dashboard_path if current_user
  end

  def ensure_team
    unless team
      case current_user.teams.size
      when 0
        redirect_to new_team_path
      when 1
        self.team = current_user.teams.first
      else
        redirect_to teams_path
      end
    end
  end

  def team=(team)
    cookies.permanent[:tid] = { value: team.id, http_only: true }
  end

  def team
    @_active_team = begin
      if cookies[:tid]
        current_user.teams.find_by(id: cookies[:tid])
      end
    rescue ActiveRecord::RecordNotFound
      cookies.delete(:tid)
      nil
    end
  end

  def signin_redirect
    if params[:continue].present? && safe_redirect(params[:continue])
      params[:continue]
    else
      dashboard_path
    end
  end

  private

  def safe_redirect(destination)
    uri = URI.parse(destination)
    (uri.scheme.nil? && uri.host.nil?) || (uri.scheme =~ /^https?$/ && uri.host == ENV['host'])
  rescue URI::InvalidURIError
    false
  end
end
