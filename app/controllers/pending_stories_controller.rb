class PendingStoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_pending_story, only: [:show, :edit, :update, :destroy]


  def edit
  end

  def update
    if @pending_story.update(pending_story_params)
      if params[:publish]
        @story.update(pending_story_params)
        redirect_to stories_path, notice: '發布成功'
        @pending_story.destroy
      else
        redirect_to edit_pending_story_path(@story), notice: '儲存成功'
      end
    else
      render :edit
    end
  end

  def destroy
    @pending_story.destroy
    redirect_to stories_path, notice: '刪除成功！'
  end
  
  private
  def find_pending_story
    @story = current_user.stories.find(params[:id])
    @pending_story = @story.pending_story
  end

  def pending_story_params
    params.require(:pending_story).permit(:title, :content)
  end

end
