class MicropostsController < ApplicationController
# This is the preferred method in Rails 4.0
#  before_action :signed_in_user, only: [:create, :destroy"]
#  before_action :correct_user, only: :destroy

# Since it's not implemented in Rails 3.2, we do it this way
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def create
#    @micropost = current_user.microposts.build(micropost_params) # Rails 4 preferred method
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private
    
    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
#      @micropost = current_user.microposts.find_by(id: params[:id]) # Preferred method on Rails 4
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
