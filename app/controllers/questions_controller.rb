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
    params = question_params
    params.tags = transform_tags(params.tags)

    @question = Question.new(params)

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

    params = question_params
    params.tags = transform_tags(params.tags)

    if @question.update(params)
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
    params.require(:question).permit(:body, :tags)
  end

  def transform_tags(tags)
    tags.map { |tag| Tag.find_or_create_by(tag) }
  end
end
