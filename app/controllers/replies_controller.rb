class RepliesController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @reply = @question.replies.create(reply_params)
    redirect_to question_path(@question)
  end

  private
  def reply_params
    params.require(:reply).permit(:body)
  end
end
