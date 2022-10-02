class StoriesController < ApplicationController
  
  before_action :authenticate_user!, except: [:love]
  before_action :find_story, only: [:show, :edit, :update, :destroy, :publish, :unpublish]
  skip_before_action :verify_authenticity_token, only: [:love]
  

  def index
    @stories = current_user.stories.order(updated_at: :desc)
  end

  def new
    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.new(story_params)

    if @story.save
      if params[:publish]
        @story.publish!
        redirect_to stories_path, notice: '發布成功'
      else
        redirect_to edit_story_path(@story), notice: '儲存成功'
      end
    else
      render :new
    end
  end

  def show
  end 

  def edit
  end

  def update
    @pending_story = @story.build_pending_story(story_params)

    if @pending_story.save
      if params[:publish]
        @story.update(story_params)
        @story.publish! if @story.may_publish?
        redirect_to stories_path, notice: '發布成功'
        @pending_story.destroy
      else
        if @story.draft?
          @story.update(story_params) 
          redirect_to edit_story_path(@story), notice: '儲存成功'
          @pending_story.destroy
        else
          redirect_to edit_pending_story_path(@story), notice: '儲存成功'
        end
      end
    else
      render :edit
    end
  end

  def destroy
    if @story.pending_story != nil
      @story.pending_story.destroy 
    else
      @story.destroy
    end
    redirect_to stories_path, notice: '刪除成功！'
  end

  def publish
    if @story.pending_story != nil
      @story.cover_image.attach(@story.pending_story.cover_image.blob) if @story.pending_story.cover_image.attached?
      @story.update(title: @story.pending_story.title, content: @story.pending_story.content)
      @story.pending_story.destroy
      redirect_to stories_path, notice: '更新成功！'    
    else
      @story.publish!
      redirect_to stories_path, notice: '發布成功！'   
    end 
  end

  def unpublish
    @story.pending_story.destroy if @story.pending_story != nil
    @story.unpublish!
    redirect_to stories_path, notice: '下架成功，移至草稿區！'    
  end

  def love
    console.log('123')

    if user_signed_in?
      @story = Story.friendly.find(params[:id])
      @story.increment(:love)
      render json: {status: @story.love}
    else
      render json: {status: 'sign_in_first'}
    end
  end

  private
  def find_story
    @story = current_user.stories.friendly.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:title, :content, :cover_image)
  end
end
