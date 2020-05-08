class RepliesController < ApplicationController
  # skip_before_action :authorized, only: [:index]

  def index
    replies = Reply.all
    render json: {replies: replies}
  end

  def create
    reply = Reply.create(reply_params)
    render json: ReplySerializer.new(reply).to_serialized_json
  end

  def update
    reply = Reply.find_by(id: params[:id])
    reply.update_attributes(reply_params)
    render json: ReplySerializer.new(reply).to_serialized_json
  end

  def destroy
    reply = Reply.find_by(id: params[:id])
    reply.destroy
    render json: {message: "success"}
  end
  private
  def reply_params
    params.require(:reply).permit(:message, :user_id, :# REVIEW: _id)
  end
end
