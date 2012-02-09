class MagazineController < ApplicationController


before_filter :network_list, :session_mail
before_filter :authorizeadmin, :except => [:list]
layout 'admin'


#-----------------Admin Methods ----------------
def index
@article = Article.find(:all, :order =>"updated_at DESC")
#@article_pages, @article = paginate :article, :per_page =>10
@query = params[:query] || ''
 unless @query.blank?
 @article = Article.find_by_contents @query
 end
end

def new
@article = Article.new
end

def category_new
@category = ArticleCategory.new
render :layout => false
end

def category
@category = ArticleCategory.find(:all)
end

def create_category
@category = ArticleCategory.new(params[:category])
@category.save
redirect_to :action => 'new'
end

def create
@article = Article.new(params[:article])
@article.user_id = session[:user]
 if @article.save
 flash[:notice] = "New Article was Successfully Created."
 redirect_to :action => 'show', :id => @article
 else
 render :action => 'new'
 end
 
end

def show
@article = Article.find(params[:id])
end

def edit
@article = Article.find(params[:id])

end

def update
@article = Article.find(params[:id])
@article.updated_at = Time.now
@article.update_attributes(params[:article])
flash[:notice] = "Article was Successfully Updated"
redirect_to :action => 'show', :id => @article
end

def delete
Article.find(params[:id]).destroy
flash[:notice] = "Article was Successfully Deleted"
redirect_to :action => 'index'
end

#--------------Member Methods-------------

def list
render :layout => 'home'
end

end
