class Admin::UsersController < ApplicationController
  before_action :only_admin

  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice:"作成しました"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice:"更新しました"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice:"削除しました"
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_digest,:password,:password_confirmation,:admin)
  end


  def only_admin
    unless current_user.admin?
      redirect_to tasks_path
      flash[:notice] = "管理者以外はアクセスできません"
    end
  end
end
