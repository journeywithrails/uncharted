class ProductsController < ApplicationController

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
     @products = Product.find(:all)
    #@product_pages, @products = paginate :products, :per_page => 2
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
	@product.user_id = session[:user].id
    if @product.save
      flash[:notice] = 'Product was successfully Saved.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = 'Product was successfully updated.'
      redirect_to :action => 'show', :id => @product
    else
      render :action => 'edit'
    end
  end

  def delete
    Product.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
