class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @sweet = current_user.sweets.build  # form_for 用
      @sweets = current_user.sweets.order('created_at DESC').page(params[:page])
    end
  end
end
