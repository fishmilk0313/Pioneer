class Hosts::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params_user)
      redirect_to users_user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def params_user
    params.require(:user).permit(
      :name,
      :email,
      :is_deleted
    )
  end
end
