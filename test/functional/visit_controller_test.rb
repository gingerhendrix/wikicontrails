require File.dirname(__FILE__) + '/../test_helper'
require 'visit_controller'

# Re-raise errors caught by the controller.
class VisitController; def rescue_action(e) raise e end; end

class VisitControllerTest < Test::Unit::TestCase
  fixtures :wiki_visits, :wiki_pages, :wikis, :users

  def setup
    @controller = VisitController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = wiki_visits(:ga_smoke_ring_visit).id
  end

  def test_index
    get :index, {}, {:user_id => 1}
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list, {}, {:user_id => 1}

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:wiki_visits)
  end

  def test_show
    get :show, {:id => @first_id},  {:user_id => 1} 

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:wiki_visit)
    assert assigns(:wiki_visit).valid?
  end

  def test_new
    get :new, {}, {:user_id => 1}

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:wiki_visit)
    assert_not_nil assigns(:wikis)
    assert_not_nil assigns(:user)
  end

  def test_create
    num_wiki_visits = WikiVisit.count

    post :create, {:wiki_visit => {}},  {:user_id => 1}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_wiki_visits + 1, WikiVisit.count
  end

  def test_edit
    get :edit, {:id => @first_id},  {:user_id => 1}
    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:wiki_visit)
    assert assigns(:wiki_visit).valid?
  end

  def test_update
    post :update, {:id => @first_id},  {:user_id => 1}
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

 
end
