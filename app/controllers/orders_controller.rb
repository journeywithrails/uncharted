class OrdersController < ApplicationController

layout 'admin'

def index

end


def list
redirect_to :action => 'index'
end

def new
@news = Testuser.new
end

def create
@news = Testuser.new(params[:user])
@news.save
redirect_to :action => 'new'
end


end