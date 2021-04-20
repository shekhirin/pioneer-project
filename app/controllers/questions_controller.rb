class QuestionsController < ApplicationController
  def index
    # This is how news.ycombinator.com sorting algorithm behaves. It's not very suitable for us, it's a good starting point for sorting though.
    @questions = Question.all.sort_by { |question| (question.views - 1) / ((Time.now - question.created_at).hours + 2) ** 1.8 }
  end

  def newest
    @questions = Question.all.order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])

    @question.increase_views
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
