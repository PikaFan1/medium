class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        @story = Story.friendly.find(params[:story_id])
        @comment = @story.comments.new(comment_params)
        @comment.user = current_user

        if @comment.save
          redirect_to story_page_path(@story)
        else
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:content)
    end
end
