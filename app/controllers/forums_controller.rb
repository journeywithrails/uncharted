class ForumsController < ApplicationController

  before_filter :authorizeadmin, :except => [:login, :index]
layout 'admin'


def list_categories
@list = ForumCategory.find :all
end

def new_category
@forum_category= ForumCategory.new
end

def create_category
@forum_category = ForumCategory.new(params[:forum_category])
if @forum_category.save
flash[:notice]= "Category was Successfully saved"
redirect_to :action => 'list_categories'
else
render :action => 'new_category'
end
end

def show_category
@list = ForumCategory.find(params[:id])
end

def edit_category
@forum_category = ForumCategory.find(params[:id])
end

def delete_category
 ForumCategory.find(params[:id]).destroy
 ForumThread.find_by_forum_category_id(params[:id]).destroy
 @post = ForumPost.find(:all, :conditions => ["forum_category_id LIKE ?",params[:id]])
 for post in @post
 post.destroy
 end

 redirect_to :action => 'list_categories'

end

def update_category
    @forum_category= ForumCategory.find(params[:id])
    if @forum_category.update_attributes(params[:forum_category])
      flash[:notice] = 'Forum was Successfully updated.'
      redirect_to :action => 'show_category', :id => @forum_category
    else
      render :action => 'edit_category'
    end
end

#methods for posts

def new_post
@forum_posts = ForumPost.new
@forum_category = ForumCategory.find(params[:id])
@forum_posts.forum_category_id = @forum_category.id
if !params[:thread_id].blank?
@forum_posts.forum_thread_id=params[:thread_id]
end
end

def show_post
@post = ForumPost.find(params[:id])
end

def create_post

@post_params = {:forum_category_id =>params[:forum_posts][:forum_category_id],:forum_thread_id=>params[:forum_posts][:forum_thread_id],:user_id=>session[:user].id, :subject=>params[:forum_posts][:subject], :content=>params[:forum_posts][:content], :created_at => Time.now}  
  @forum_posts = ForumPost.new(@post_params)   
  if @forum_posts.save       
   @thread_params = {:forum_category_id=>@forum_posts.forum_category_id,:forum_post_id=>@forum_posts.id,:user_id=>session[:user].id}
   if params[:forum_posts][:forum_thread_id]=='0'
   @thread = ForumThread.new(@thread_params)
   if @thread.save 
    @forum_posts.update_attribute("forum_thread_id", @thread.id)
    end
  end
  flash[:notice]="Post was Successfully Saved"
  redirect_to :action => 'posts', :id => params[:forum_posts][:forum_category_id]
  else
  render :action => new_post,:forum_thread_id =>params[:forum_posts][:forum_thread_id],:id => params[:forum_posts][:forum_category_id]
end

end

def edit_post
@post = ForumPost.find(params[:id])
end

def update_post
@post = ForumPost.find(params[:id])
if @post.update_attributes(params[:post])
flash[:notice]="Post was Successfully Updated"
redirect_to :action => 'posts', :id => @post.forum_category_id
else
render :action => 'edit_post'
end
end

def destroy_post
@post = ForumPost.find(params[:id])
ForumThread.find(@post.forum_thread_id).destroy
@post.destroy
redirect_to :action => 'posts', :id => @post.forum_category_id
end

def posts
@list = ForumThread.find(:all, :conditions =>["forum_category_id LIKE ?", params[:id]])
@category_title = ForumCategory.find(params[:id])
end

def reply_post
@list = ForumPost.find(:all, :conditions =>["forum_thread_id LIKE ?", params[:id]])
@thread = ForumThread.find(:first, :conditions => ["id LIKE ?",params[:id]])
@category_title = ForumCategory.find(@thread.forum_category_id)
end

end
