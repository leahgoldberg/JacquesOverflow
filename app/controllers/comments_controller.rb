class CommentsController < ApplicationController
  before_action :find_question
  before_action :authenticate_user

  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to question_path(question)
    else
      flash[:error] = "Comment must be 1500 chars or less."
      redirect_to question_path(question)
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to question_path(question)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_question
    question = Question.find(comment.id)
  end

  def authenticate_user
    redirect_to root_path if !current_user
  end
end
