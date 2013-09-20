class MicropostsController < ApplicationController
# This is the preferred method in Rails 4.0
#  before_action :signed_in_user

# Since it's not implemented in Rails 3.2, we do it this way
  before_filter :signed_in_user

  def create
#    @micropost = current_user.microposts.build(micropost_params) # Rails 4 preferred method
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private
    
    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
