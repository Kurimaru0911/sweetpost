class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.all.page(params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @sweets = @user.sweets.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
    @prefectures = Prefecture.all
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @prefectures = Prefecture.all
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'User は正常に更新されました'
      redirect_to user_path
    else
      flash.now[:danger] = 'User は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    flash[:success] = 'User は正常に削除されました'
    redirect_to root_url
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def favorites
    @user = User.find(params[:id])
    @sweets = @user.feed_favorites.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def wents
    @user = User.find(params[:id])
    @sweet_wents = @user.feed_wents.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
