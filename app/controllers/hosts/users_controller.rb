class Hosts::UsersController < ApplicationController
  before_action :authenticate_host!

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params_user)
      redirect_to hosts_users_path
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
