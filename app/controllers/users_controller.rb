class UsersController < ApplicationController
  before_action :require_user_logged_in,only: [:destroy]
  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success]='ユーザーを登録しました'
      redirect_to tasks_url
    else
      flash.now[:danger]='ユーザーの登録に失敗しました'
      render :new
    end
    
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
   private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
