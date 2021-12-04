class ApplicationController < ActionController::Base
  before_action(:load_current_user)
  
  # Uncomment this if you want to force users to sign in before any other actions
  # before_action(:force_user_sign_in)
  
  def load_current_user
    the_id = session[:user_id]
    @current_user = User.where({ :id => the_id }).first
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end


  def index

    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc})
    render({ :template => "user/index.html.erb" })
  end


  
def show
  
  # Parameters: {"path_username"=>"anisa"}
   url_username = params.fetch("path_username")
 
   matching_usernames = User.where({:username => url_username})
 
   @the_user = matching_usernames.at(0)
 
   if @the_user == nil
     redirect_to("/404")
   else
 
   render({:template => "user/show.html.erb"})
   end
 
 end

 def liked_photos
  
  # Parameters: {"path_username"=>"anisa"}
   url_username = params.fetch("path_username")
 
   matching_usernames = User.where({:username => url_username})
 
   @the_user = matching_usernames.at(0)
 
   if @the_user == nil
     redirect_to("/404")
   else
 
   render({:template => "user/liked_photos.html.erb"})
   end
 
 end


 def feed
  
  # Parameters: {"path_username"=>"anisa"}
   url_username = params.fetch("path_username")
 
   matching_usernames = User.where({:username => url_username})
 
   @the_user = matching_usernames.at(0)


 
   if @the_user == nil
     redirect_to("/404")
   else
 
   render({:template => "user/feed.html.erb"})
   end
 
 end


 def discover
  
  # Parameters: {"path_username"=>"anisa"}
   url_username = params.fetch("path_username")
 
   matching_usernames = User.where({:username => url_username})
 
   @the_user = matching_usernames.at(0)
 
   if @the_user == nil
     redirect_to("/404")
   else
 
   render({:template => "user/discover.html.erb"})
   end
 
 end

end
