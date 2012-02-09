class EventsController < ApplicationController
  
before_filter :login_required
before_filter :network_list, :session_mail
layout 'home'
  
	def index
		@months = []
		mons = Event.find :all, :conditions=>{:suggestion=>1},:group=>"MONTH(event_date)"
        for month in mons 
        	mon = {
        	:event_month =>month.event_date.strftime('%B %Y'),
        	:events =>Event.find(:all, :conditions=>["MONTH(event_date) = ? AND suggestion = 1", month.event_date.month])
        	}
        	@months << mon
        end
		render :template => 'events/event_container'
	end
	
	def suggest_event
	   @event = Event.new
	   render :template=>'events/event_container'
	end
	
	def post_event
		@event = Event.new(params[:event])
		@event.user_id = session[:user].id
		if @event.save
		flash[:notice] = "New Event was Successfully posted and will appear once the Admin Approves it"
		redirect_to events_path and return
		else
		flash[:notice] = "Unable to add new Event "
		render :template=>'events/event_container'
		end
	end
	
  def details
	@event = Event.find(params[:id])
	end
	
end
