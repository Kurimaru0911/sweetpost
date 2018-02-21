class PrefecturesController < ApplicationController
  def index
  end

  def show
    @code = params[:code]
    @user = User.all.page(params[:page])
    @sweets = Sweet.where(prefecture_id: @code).order('created_at DESC').page(params[:page])
    count = Sweet.joins(:favorites).group(:sweet_id).count
    ids = Hash[count.sort_by{ |_, v| -v }].keys
    @rank= Sweet.where(id: ids,prefecture_id: @code)
    @prefecture = Prefecture.find(@code)
  end
end
