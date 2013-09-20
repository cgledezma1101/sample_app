class RelationshipsController < ApplicationController
# Preferred method on Rails 4
#  before_action :signed_in_user 

# Since it's not implemented on Rails 3.2, we use this:
  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_with @user
# A way of doing it without respond_to up there
#    respond_to do |format|
#      format.html { redirect_to @user }
#      format.js
#    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
#    respond_to do |format|
#      format.html { redirect_to @user }
#      format.js
#    end
  end
end
