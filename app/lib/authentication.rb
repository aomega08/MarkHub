class Authentication
  attr_accessor :context

  def initialize(context)
    self.context = context
  end

  def current_user
    @user ||= begin
      User.find(context.session[:user_id]) if context.session[:user_id]
    end
  end

  def signin(user)
    context.reset_session
    context.session[:user_id] = user.id
  end

  def signout
    context.session.delete(:user_id)
  end
end
