class SweetsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @sweet = current_user.sweets.build(sweet_params)
    if @sweet.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @sweets = current_user.feed_sweets.order('created_at DESC').page(params[:page])
      @prefectures = Prefecture.all
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @sweet.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def show 
    @sweet = Sweet.find(params[:id])
    @comment = Comment.new
    @user = User.find_by(id: @sweet.user_id)
  end
  
  def edit
    @sweet = Sweet.find(params[:id])
    @prefectures = Prefecture.all
  end
  
  def update
    @sweet = Sweet.find(params[:id])

    if @sweet.update(sweet_params)
      flash[:success] = 'Sweet は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Sweet は更新されませんでした'
      render :edit
    end
  end

  private

  def sweet_params
    params.require(:sweet).permit(:content)
  end

  def correct_user
    @sweet = current_user.sweets.find_by(id: params[:id])
    unless @sweet
      redirect_to root_url
    end
  end
  
  private
    def sweet_params
      params.require(:sweet).permit(:name, :content, :prefecture_id, :image, :image_cache)
    end
end