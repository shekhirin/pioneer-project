class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])

    if @tag
      counter = Hash.new(0)

      @tag.questions.each { |question|
        question.tags.each { |tag|
          next if tag == @tag
          counter[tag] += 1
        }
      }

      @similar_tags = counter.sort_by {|_, value| value}.first(10).map do |tag, _|
        tag
      end
    end
  end
end
