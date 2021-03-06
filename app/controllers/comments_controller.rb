class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:id]
      @comments = Activity.find(params[:activity_id]).trackable.root_comments.where('id < ?', params[:id]).limit(2)
      # @comments = Activity.find(11).trackable.root_comments.limit(2)
    else
      @comments = Activity.find(params[:activity_id]).trackable.root_comments.limit(2)
      # @comments = Activity.find(11).trackable.root_comments.limit(2)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    commentable = commentable_type.constantize.find(commentable_id)
    @comment = Comment.build_from(commentable, current_user.id, body)

    if @comment.save
      @comment.send_notifications!
      make_child_comment
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type, :comment_id)
  end

  def commentable_type
    comment_params[:commentable_type]
  end

  def commentable_id
    comment_params[:commentable_id]
  end

  def comment_id
    comment_params[:comment_id]
  end

  def body
    comment_params[:body]
  end

  def make_child_comment
    return "" if comment_id.blank?

    parent_comment = Comment.find comment_id
    @comment.move_to_child_of(parent_comment)
  end

end
