class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password

  helper_method :current_user, :url_base, :url_path

  private
  
  def current_user_session  
    return @current_user_session if defined?(@current_user_session)  
    @current_user_session = UserSession.find  
  end  

  def current_user  
    @current_user = current_user_session && current_user_session.record  
  end

  def require_user
    unless current_user
      store_location
      flash[:message] = "You must log in to access this page."
      redirect_to login_url
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def url_base
    request.env['HTTP_HOST']
  end  
  
  def url_path
    request.env['REQUEST_URI']
  end
  
end
