class UsersController < ApplicationController

  def index
    if params.key?(:search_email)
      email = params[:search_email]
      @users = User.search_email(email)
    else
      @users = []
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following
  end


end
