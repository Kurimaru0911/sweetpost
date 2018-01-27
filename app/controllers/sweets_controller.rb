class SweetsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @sweet = current_user.sweets.build(sweet_params)
    if @sweet.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @sweets = current_user.sweets.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @sweet.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
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
end