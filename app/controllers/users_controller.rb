class UsersController < ApplicationController

  def index
    matching_users = User.all
    @users = matching_users.order(:username => :asc)
    

    render({ :template => "user_templates/all_users.html.erb"})
  end
  
  def show
    username = params.fetch("username")
    matching_users = User.where({ :username => username })
    @user = matching_users.at(0)

    render({ :template => "user_templates/user_details.html.erb"})
  end
  
  def create
    user = User.new
    user.username = params.fetch("query_username")
    user.save
    
    redirect_to("/users/" + user.username)
  end
  
  def update
    new_username = params.fetch("query_username")
    user_id = params.fetch("user_id")
    matching_users = User.where({ :username => user_id })
    the_user = matching_users.first
    
    the_user.username = new_username

    the_user.save

    redirect_to("/users/"+the_user.username)
  end

end
