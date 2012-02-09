module UserHelper
def sort_link_helper(text, param)
  key = param
  key += "_reverse" if @params[:sort] == param
  options = {
      :url => {:action => 'list', :params => @params.merge({:sort => key})},
        }
  html_options = {
    :title => "Sort by this field",
    :href => url_for(:action => 'list', :params => @params.merge({:sort => key}))
  }
  link_to_remote(text, options, html_options)
end
end
