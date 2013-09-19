class UsersController < ApplicationController
# Preferred method on Rails 4.0
#  before_action :signed_in_user, only: [:edit, :update, :index] 
#  before_action :correct_user, only: [:edit, :update]

# Since it's not implemented on Rails 3, do it this way
  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
#    @user = User.new(user_params) # This is the preferred method in Rails 4.0
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the sample app!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
#    if @user.update_attributes(user_params) #This is the preferred method in Rails 4.0
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before the filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
