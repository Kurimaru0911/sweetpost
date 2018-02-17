class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @sweet = current_user.sweets.build  # form_for 用
      @sweets = current_user.feed_sweets.order('created_at DESC').page(params[:page])
      @prefectures = Prefecture.all
    else
      @user = User.all.page(params[:page])
      @sweets = Sweet.all.order('created_at DESC').page(params[:page])
      @rank = Sweet.find(Favorite.group(:sweet_id).order('count(sweet_id) desc').pluck(:sweet_id))
    end
  end
end
