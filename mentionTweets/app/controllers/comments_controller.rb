class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @mention = Mention.find(params[:mention])
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to mentions_path, notice: 'Comment was successfully created.'  }
      else
        format.html { redirect_to mentions_path, alert: 'Comment NOT created.'  }
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:text, :mention_id)
    end
end
