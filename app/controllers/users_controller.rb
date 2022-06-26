class UsersController < ApplicationController
  def index
    @users = User.order(created_at: :desc)
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(users_params)
      redirect_to users_url
    else
      render :edit
    end
  end
  
  private
  def users_params
    params.require(:user).permit({role_ids: []})
  end
end
