class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to root_path
  end

  private

  def question_params
    q_params = params.require(:question).permit(:body, :tags, :manual_tags)

    if q_params[:manual_tags]
      q_params[:tags] = q_params.delete(:manual_tags).split(',')
    end

    q_params[:tags] = (q_params[:tags] || []).map { |tag| Tag.find_or_create_by(name: tag.strip) }

    q_params
  end
end
