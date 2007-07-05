class VisitController < ApplicationController

  before_filter :authorize

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create ],
         :redirect_to => { :action => :list }

  def list
   @user = User.find session[:user_id]
   @wiki_visit_pages, @wiki_visits = paginate :wiki_visits, :per_page => 10, :order => "time_of_visit DESC", :conditions => "user_id = #{@user.id}"
  end


  def new
    @wiki_visit = WikiVisit.new
    @user = User.find session[:user_id]
    @wikis = Wiki.find(:all).map {|w| [w.name, w.id]} 
  end

  def create
    if(params[:type] && params[:type]=="full")
      @wiki_page = WikiPage.new(params[:wiki_page])
      if @wiki_page.save
        params[:wiki_visit][:user_id] = session[:user_id]
        params[:wiki_visit][:wiki_page_id] = @wiki_page.id
        @wiki_visit = WikiVisit.new(params[:wiki_visit])
        if @wiki_visit.save
          flash[:notice] = 'WikiVisit was successfully created.'
          redirect_to :action => 'list' and return
        end
      end
    else
      url = params[:wiki_page][:url]
      @wiki = false
      Wiki.find(:all).map do |w| 
        if url.slice!(w.base_url) 
          @wiki = w
        end
      end 
      if !@wiki
          flash[:error] = 'URL does not correspond to known wiki.'
          render :action => 'new'
      end
      page_name = url;
      page_title = url.sub("_", " ")
      @wiki_page = WikiPage.create :wiki_id => @wiki.id, :name => page_name, :title => page_title
      if !params[:wiki_visit]
        params[:wiki_visit] = Hash.new
      end
      if !params[:wiki_visit][:time_of_visit]
        params[:wiki_visit][:time_of_visit] = DateTime.now
      end
      params[:wiki_visit][:user_id] = session[:user_id]
      params[:wiki_visit][:wiki_page_id] = @wiki_page.id
      @wiki_visit = WikiVisit.new(params[:wiki_visit])
      if @wiki_visit.save
          flash[:notice] = 'WikiVisit was successfully created.'
          redirect_to :action => 'list' and return
      end
    end
    render :action => 'new'
  end


end
