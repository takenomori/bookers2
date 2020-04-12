class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authuser, {only:[:edit]}

  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def users
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:message] = "You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end

    def authuser
      user = User.find(params[:id])
      if user.id != current_user.id
        redirect_to user_path(current_user)
      end
    end
end