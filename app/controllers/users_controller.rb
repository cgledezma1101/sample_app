class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
#    @user = User.new(user_params) # This is the preferred method in Rails 4.0
    if @user.save
      # Handle a successful save
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
