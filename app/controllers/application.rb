# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_WikiContrails_session_id'
  
  
  def authorize
    logger.info("Params[:auth] #{params[:auth]}")
    if !params[:auth] || !(params[:auth] == "http")
      logger.info("Session login") 
      unless session[:user_id]
         logger.info("User not logged in redirecting")
            flash[:notice] = "Please log-in"
            redirect_to :controller => "login", :action => "index"
      end
    else
      logger.info("HTTP-auth login")
      http_authorize
    end
  end
  
  def logged_in?  
     if session[:user_id] then return true else return false end
  end
  
  def http_authorize(realm='Wiki Contrails', errormessage="Could't authenticate you")
      username, passwd = get_auth_data 
      # check if authorized 
      # try to get user 
      if user = User.login(username, passwd) 
        # user exists and password is correct ... horray! 
        session[:user_id] = user.id 
      else 
        # the user does not exist or the password was wrong 
        response.headers["Status"] = "Unauthorized" 
        response.headers["WWW-Authenticate"] = "Basic realm=\"#{realm}\"" 
        render :text => errormessage, :status => 401 and return      
      end
  end 

  private 
  def get_auth_data 
    user, pass = '', '' 
    # extract authorisation credentials 
    if request.env.has_key? 'X-HTTP_AUTHORIZATION' 
      # try to get it where mod_rewrite might have put it 
      authdata = request.env['X-HTTP_AUTHORIZATION'].to_s.split 
    elsif request.env.has_key? 'Authorization' 
      # for Apace/mod_fastcgi with -pass-header Authorization 
      authdata = request.env['Authorization'].to_s.split 
    elsif request.env.has_key? 'HTTP_AUTHORIZATION' 
      # this is the regular location 
      authdata = request.env['HTTP_AUTHORIZATION'].to_s.split  
    elsif request.env.has_key? 'Authorization'
      # this is the regular location, for Apache 2
      authdata = request.env['Authorization'].to_s.split
    end 

    # at the moment we only support basic authentication 
    if authdata and authdata[0] == 'Basic' 
      user, pass = Base64.decode64(authdata[1]).split(':')[0..1] 
    end 
    return [user, pass] 
  end
end
