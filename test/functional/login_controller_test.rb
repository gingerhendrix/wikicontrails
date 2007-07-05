require File.dirname(__FILE__) + '/../test_helper'
require 'login_controller'

# Re-raise errors caught by the controller.
class LoginController; def rescue_action(e) raise e end; end

class LoginControllerTest < Test::Unit::TestCase
  fixtures :users
  
  def setup
    @controller = LoginController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_valid_login
    login
  end
  
  def test_invalid_login
    post :login, :login => {:username=>"ga", :password=>"drowssap"}
    assert_redirected_to :controller => "login", :action => "index"
    assert_equal "Login failed. Try again", flash[:error]
    assert_nil session[:user_id]
  end
  
  
end
