class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
      if @comment.save
        redirect_to prototype_path(@comment.prototype) 
      else
        @prototypes = @comment.prototype
        @comments = @prototypes.comments
        render "prototypes/show"
      end
  end

  def show
    @comment = Comment.all
    @comments = @prototypes.comments.includes(:prototypes)
  end


  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end