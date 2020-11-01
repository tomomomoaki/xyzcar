class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.valid?
      @comment.save
      redirect_to car_path(@comment.car)
    else
      @car = @comment.car
      render 'cars/show'

    end
      
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, car_id: params[:car_id] )
  end

end
