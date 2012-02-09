class ForumController < ApplicationController

before_filter :login_required
before_filter :network_list, :session_mail
layout 'home'


def show_categories
		@categories = ForumCategory.find :all
		@type = "category_list"
		respond_to do |f|
			f.html{render :template=> 'forum/forum_container', :locals=>{:type=>@type, :categories=>@categories}}
		end
end
	
	def list_threads
		@category_title = params[:category].empty? ? nil : params[:category]
		#if the category is nil we send them to the home page for now
		if !@category_title
			redirect_to home_url
		else
			@categories = list_categories
			@category = ForumCategory.find :first, :conditions=>{:title=>remove_underscore(@category_title)}
			@threads = ForumThread.find :all, :conditions=>{:forum_category_id=>@category.id}, :include=>[:forum_posts, :users], :order=>"forum_post_id DESC"
			@type = "threads_list"
			respond_to do |f|
				f.html{render :template=>'forum/forum_container', :locals=>{:type=>@type, :category=>@category, :threads=>@threads, :categories=>@categories, :category_title=>@category_title}}
			end
			
		end
	end
	
	def new_post
		category_title = params[:category].empty? ? nil : params[:category]
		#if the category is nil we send them to the home page for now
		if !category_title
			redirect_to home_url
		else
			@categories = list_categories
			@category = ForumCategory.find :first, :conditions=>{:title=>remove_underscore(category_title)}
			@threads = ForumThread.find :all, :conditions=>{:forum_category_id=>@category.id}, :include=>[:forum_posts, :users], :order=>"forum_post_id DESC"
			@type = "threads_list"
			@sub_type = "new_post"
			@category_title = params[:category]
			@post_path = add_new_forum_post_path(:category=>params[:category].gsub(' ', '_'))
			respond_to do |f|
		f.html{render :template=>'forum/forum_container', :locals=>{:type=>@type, :sub_type=>@sub_type, :category=>@category,:categories=>@categories}}
			end
			
		end	
	end
	
	def add_post 
		@category_title = params[:category].empty? ? nil : params[:category]
		if !@category_title
			redirect_to home_url
		else 
			@category = ForumCategory.find :first, :conditions=>{:title=>remove_underscore(@category_title)}
			if @category 
			
			@post_params = {:forum_category_id =>@category.id,:forum_thread_id=>0,:user_id=>session[:user].id, :subject=>params[:subject], :content=>params[:content], :created_at=>Time.now}
			@post = ForumPost.new(@post_params)
			if @post.save			
				@thread_params = {:forum_category_id=>@post.forum_category_id,:forum_post_id=>@post.id,:user_id=>session[:user].id}
				@thread = ForumThread.new(@thread_params)
				@thread.save!	
				if @thread 
					@post.update_attribute("forum_thread_id", @thread.id)
				end
				flash[:notice] = "Post was Successfully Saved"
redirect_to show_forum_posts_path(:category=>@category_title.gsub(' ', '_'), :id=>@thread.id, :thread=>@post.subject.gsub(' ', '_'))				
				else	
				flash[:notice] = "Unable to save the Post"			
				redirect_to forum_category_path(:category=>@category_title.gsub(' ', '_'))				
				end
			end
		end
	end
	
	def show_posts
		category_title = params[:category].empty? ? nil : params[:category]
		thread_id = params[:id]
		#if the category is nil we send them to the home page for now
		if !category_title
			redirect_to home_url
		else
			@categories = list_categories
			@category = ForumCategory.find :first, :conditions=>{:title=>remove_underscore(category_title)}
			@threads = ForumThread.find :all, :conditions=>{:forum_category_id=>@category.id}, :include=>[:forum_posts, :users], :order=>"forum_post_id DESC"
			@category_title = params[:category].empty? ? nil : params[:category]
			@thread_title = params[:thread].empty? ? nil : params[:thread]
			@thread_id = thread_id
			@type = "threads_list"
			@posts = ForumPost.find :all, :conditions=>{:forum_thread_id=>thread_id}, :include=>:user
			respond_to do |f|
				f.html{render :template=>'forum/forum_container', :locals=>{:type=>@type, :category=>@category, :threads=>@threads, :categories=>@categories, :category_title=>@category_title.gsub(' ', '_'), :thread_title=>@thread_title, :thread_id=>@thread_id}}
				f.js{render(:update){|page|
				  page.replace_html 'post_list', :partial=>"forum_post", :locals=>{:first=>true, :reply=>false, :posts=>@posts, :counter=>0, :total=>@posts.length - 1, :category_title=>@category_title.gsub(' ', '_'), :thread_title=>@thread_title, :thread_id=>@thread_id}
				}}
			end
			
		end
	end
	
	
	def new_reply
		category_title = params[:category].empty? ? nil : params[:category]
		thread_id = params[:id]
		#if the category is nil we send them to the home page for now
		if !thread_id
			redirect_to home_url
		else
			@categories = list_categories
			@category = ForumCategory.find :first, :conditions=>{:title=>remove_underscore(category_title)}
			@threads = ForumThread.find :all, :conditions=>{:forum_category_id=>@category.id}, :include=>[:forum_posts, :users], :order=>"forum_post_id DESC"
			@type = "threads_list"
			@sub_type = "new_reply"
			@category_title = params[:category]
			@thread_id = params[:id]
			@thread_title = params[:thread]
			@post_path = post_forum_reply_path(:category=>params[:category].gsub(' ', '_'), :id=>params[:id], :thread=>params[:thread])
			@posts = ForumPost.find :all, :conditions=>{:forum_thread_id=>thread_id}, :include=>:user
			respond_to do |f|
				f.html{render :template=>'forum/forum_container', :locals=>{:type=>@type, :sub_type=>@sub_type, :category=>@category, :threads=>@threads, :categories=>@categories, :thread_title=>@thread_title}}
				f.js{render(:update){|page|
				  page.replace_html 'post_list', :partial=>"forum_post", :locals=>{:first=>true, :reply=>false, :posts=>@posts, :counter=>0, :total=>@posts.length - 1}
				}}
			end
			
		end
	end
	
	def post_reply
		@thread_id = params[:id].empty? ? nil : params[:id]
		if @thread_id
			@post_params = {:forum_thread_id=>@thread_id, :user_id=>session[:user].id, :subject=>"RE", :content=>params[:content], :created_at=>Time.now}
			@post = ForumPost.new(@post_params)
			if @post.save
			flash[:notice]="Post was Successfully saved"
			redirect_to show_forum_posts_path(:category=>params[:category], :id=>params[:id], :thread=>params[:thread])
			else
			flash[:notice]="Unable to save the post"
			redirect_to show_forum_posts_path(:category=>params[:category], :id=>params[:id], :thread=>params[:thread])
			end
		end
	end
	
    private
    
    def list_categories
		@categories = ForumCategory.find :all, :include=>:forum_threads
	end
	
    def remove_underscore(str)
    	ret = str.gsub!('_', ' ')
      	@str = (ret)? ret : str
    end
end
