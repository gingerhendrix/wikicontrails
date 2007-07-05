
class IndexController < ApplicationController
  def index
    if logged_in?
        redirect_to :controller => "visit", :action => "index"
    end
  end
end