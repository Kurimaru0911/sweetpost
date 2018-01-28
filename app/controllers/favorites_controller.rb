class FavoritesController < ApplicationController
  
  def create
    p '------------create'
    p sweet = Sweet.find(params[:sweet_id])
    current_user.favorite(sweet)
    flash[:success] = 'お気に入りに登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    p sweet = Sweet.find(params[:sweet_id])
    current_user.unfavorite(sweet)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
