class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to prototype_path(params[:prototype_id])}
        format.json
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to prototype_path(params[:prototype_id]) }
        format.json {render json: @comment}
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user.id == current_user.id
      if @comment.destroy
        respond_to do |format|
          format.html { redirect_to prototype_path(params[:prototype_id]) }
          format.json {render json: @comment}
        end
      end

    end
  end


  private

    def comment_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
    end
end
