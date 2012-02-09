class NewsController < ApplicationController

  before_filter :authorizeadmin, :except => [:login, :index]
layout "admin"  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @news = SiteNew.find(:all)
     #@site_new_pages, @news = paginate :site_new, :per_page =>10
  end

  def show
    @site_new = SiteNew.find(params[:id])
  end

  def new
    @site_new = SiteNew.new
  end

  def create
    @site_new = SiteNew.new(params[:site_new])
    if @site_new.save
      flash[:notice] = 'new was successfully Saved.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @site_new = SiteNew.find(params[:id])
  end

  def update
    @site_new = SiteNew.find(params[:id])
    if @site_new.update_attributes(params[:site_new])
      flash[:notice] = 'News was successfully updated.'
      redirect_to :action => 'show', :id => @site_new
    else
      render :action => 'edit'
    end
  end

  def delete
    SiteNew.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

end
