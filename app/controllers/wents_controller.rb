class WentsController < ApplicationController
  
  def create
    p '------------create'
    p sweet = Sweet.find(params[:sweet_id])
    current_user.went(sweet)
    flash[:success] = '行ってきたよに登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    p sweet = Sweet.find(params[:sweet_id])
    current_user.unwent(sweet)
    flash[:success] = '行ってきたよを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
