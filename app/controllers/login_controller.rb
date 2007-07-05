class LoginController < ApplicationController
  verify :method => :post, :only => [ :login ],
         :redirect_to => { :action => :index }
         
  def index
    
  end

  def login
    username = params[:login][:username]
    password = params[:login][:password]
    if user = User.login(username, password)
      flash[:notice] = "Welcome #{user.username}" 
      session[:user_id] = user.id 
    else 
      logger.debug("Login failed for #{username} and #{password}")
      flash[:error] = "Login failed. Try again"
      redirect_to :action => "index" and return
    end
    redirect_to :controller => "visit", :action => "index"
  end

  def logout
   session[:user_id] = nil
   redirect_to :controller => "index", :action => "index"
  end

end
