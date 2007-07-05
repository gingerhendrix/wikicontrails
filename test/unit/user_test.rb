require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase
  fixtures :users

  def setup
    @user = User.find 1
  end

  # Replace this with your real tests.
  def test_accessors
    assert_kind_of User, @user
    assert_equal "ga", @user.username
    assert_equal "********",  @user.password
  end
  
  def test_login
    @user = User.login("ga", "password")
    assert_not_nil @user
    assert_equal "ga", @user.username
  end
end
