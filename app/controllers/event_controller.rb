class EventController < ApplicationController
  
  before_filter :authorizeadmin, :except => [:login, :index]
  layout 'admin'

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
   page = params[:page].blank? ? 1 : params[:page]
   if params[:event_status]== '0'
   @events = Event.paginate :per_page=>5, :page => page, :conditions =>("suggestion = 0") , :order => 'created_at DESC'
   @total = Event.count(:all,:conditions =>("suggestion = 0"))    
   elsif params[:event_status]=='1'
   @events = Event.paginate :per_page=>5, :page => page, :conditions =>("suggestion = 1") , :order => 'created_at DESC'
   @total = Event.count(:all,:conditions =>("suggestion = 1"))     
	elsif params[:event_status]=='2'
	@events = Event.paginate :per_page=>5, :page => page, :order => 'created_at DESC'
	@total = Event.count(:all)
  else  
  @events = Event.paginate :per_page=>5, :page => page, :conditions =>("suggestion = 0"), :order => 'created_at DESC'
  @total = Event.count(:all,:conditions =>("suggestion = 0"))   

	end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
	@event.user_id = session[:user].id
    if @event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event was successfully updated.'
      redirect_to :action => 'show', :id => @event.id
    else
      render :action => 'edit'
    end
  end
  
  def admin_approve_old
   events = params[:approve_list]
   for event in events   
   @approve = Event.find_by_id(event)
   if params[:temp] == 1
   @approve.update_attributes("suggestion",'1')
   #@approve.suggestion=1
   elsif params[:temp] == 0
   @approve.update_attributes("suggestion",'0')
   end   
   #@approve.update_attributes(params[:approve])
   end
   redirect_to :action => 'list' 
  end

  def admin_approve
     @event = Event.find(params[:id]) 
     @event.suggestion = 1 
     
     if @event.update_attributes(params[:event])
     flash[:notice] = 'Event was successfully Approved.'
      redirect_to :action => 'list', :event_status => 1
     else     
     flash[:notice] = 'Unable to approve this Event.'
     redirect_to :action => 'list', :event_status =>  0  
     end
     
    end  


  def delete
    Event.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
