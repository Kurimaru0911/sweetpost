class CommentsController < ApplicationController

  def create
    @sweet=Sweet.find(params[:sweet_id])
    @comment = @sweet.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to sweet_path(@sweet)
    else
      render "sweets/show"
    end

  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
     redirect_to  request.referrer || root_url
  end

  private 

  def comment_params
    params.require(:comment).permit(:content)
  end


end
